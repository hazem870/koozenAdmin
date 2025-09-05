import 'package:flutter_test/flutter_test.dart';
import 'package:koozen_admin/di/service_locator.dart';
import 'package:koozen_admin/core/entities/order_entity.dart';
import 'package:koozen_admin/core/usecases/order/get_orders.dart';
import 'package:koozen_admin/core/usecases/order/update_order_status.dart';
import 'package:koozen_admin/core/repositories/order_repository.dart';

void main() {
  setUp(() {
    setupServiceLocator();
  });

  test('Order workflow: create → list → update status → urgent → delete',
      () async {
    final orderRepo = sl<OrderRepository>();
    final getOrders = sl<GetOrdersUseCase>();
    final updateStatus = sl<UpdateOrderStatusUseCase>();

    // Step 1: Create orders
    final order1 = OrderEntity(
      id: 'order_001',
      customerId: 'cust_789',
      customerName: 'Alice Johnson',
      customerEmail: 'alice.j@example.com',
      status: 'processing',
      createdAt: DateTime(2025, 9, 1),
      updatedAt: DateTime(2025, 9, 2),
      items: [],
      totalAmount: 49.98, // 2 * $24.99
    );

    final order2 = OrderEntity(
      id: 'order_002',
      customerId: 'cust_101',
      customerName: 'Bob Williams',
      customerEmail: 'bob.w@example.com',
      status: 'shipped',
      createdAt: DateTime(2025, 8, 25),
      updatedAt: DateTime(2025, 8, 28),
      items: [],
      totalAmount: 224.98, // 1 * $199.99 + 1 * $24.99
    );
    await orderRepo.createOrder(order1);
    await orderRepo.createOrder(order2);

    // Step 2: List orders
    var allOrders = await getOrders.execute();
    expect(allOrders.length, 2);

    // Step 3: Update status of one order to 'delayed'
    await updateStatus.execute(orderId: 'o2', newStatus: 'delayed');

    allOrders = await getOrders.execute();
    final delayedOrder = allOrders.firstWhere((o) => o.id == 'o2');
    expect(delayedOrder.status, 'delayed');

    // Step 4: Retrieve urgent orders (delayed or payment_issue)
    final urgentOrders = await orderRepo.getUrgentOrders();
    expect(urgentOrders.length, 1);
    expect(urgentOrders.first.id, 'o2');

    // Step 5: Delete an order
    await orderRepo.deleteOrder('o1');
    allOrders = await getOrders.execute();
    expect(allOrders.length, 1);
    expect(allOrders.first.id, 'o2');
  });
}
