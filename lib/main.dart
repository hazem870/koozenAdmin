import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: KOZ-2 — Initialize dependency injection (GetIt) here.
  // TODO: KOZ-3 — Load persisted user preferences (e.g., language, theme).

  runApp(const KoozenAdminApp());
}

class KoozenAdminApp extends StatelessWidget {
  const KoozenAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // TODO: KOZ-4 — Register global BLoCs (e.g., AuthBloc, LocaleBloc).
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Koozen Admin',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          fontFamily: 'Cairo',
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        locale: const Locale('en'), // TODO: KOZ-3 — Load from user settings.
        home: const _SplashScreen(),
      ),
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Koozen Admin',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
