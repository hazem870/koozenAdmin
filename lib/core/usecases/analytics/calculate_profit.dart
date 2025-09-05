/// Result model for profit calculation.
class ProfitResult {
  // percentage

  const ProfitResult({
    required this.totalRevenue,
    required this.totalCost,
    required this.totalExpenses,
    required this.netProfit,
    required this.profitMargin,
  });
  final double totalRevenue;
  final double totalCost;
  final double totalExpenses;
  final double netProfit;
  final double profitMargin;
}

/// Use case for calculating profit and profit margin.
/// Can be used in analytics dashboards, reports, or forecasting.
class CalculateProfitUseCase {
  const CalculateProfitUseCase();

  /// Executes the profit calculation.
  ///
  /// [totalRevenue] — total sales revenue.
  /// [totalCost] — cost of goods sold (COGS).
  /// [totalExpenses] — additional expenses (e.g., shipping, marketing).
  ///
  /// Returns a [ProfitResult] with net profit and margin.
  ProfitResult execute({
    required double totalRevenue,
    required double totalCost,
    double totalExpenses = 0.0,
  }) {
    final netProfit = totalRevenue - totalCost - totalExpenses;
    final profitMargin =
        totalRevenue > 0 ? (netProfit / totalRevenue) * 100 : 0.0;

    return ProfitResult(
      totalRevenue: totalRevenue,
      totalCost: totalCost,
      totalExpenses: totalExpenses,
      netProfit: netProfit,
      profitMargin: profitMargin,
    );
  }
}
