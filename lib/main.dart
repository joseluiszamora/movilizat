import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movilizat/core/blocs/auth/auth_bloc.dart' as custom_auth;
import 'package:movilizat/core/routes/app_router.dart';
import 'package:movilizat/core/themes/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar Firebase
  await Firebase.initializeApp();
  // Inicializar FlutterSecureStorage
  const secureStorage = FlutterSecureStorage();

  await Supabase.initialize(
    url: 'https://nqvzmratixdaoqpxrumh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5xdnptcmF0aXhkYW9xcHhydW1oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMwMTc1NTMsImV4cCI6MjA1ODU5MzU1M30.hDEItAepVK5KHBtowuBMi5DI9F5KoNAwOuHeV_ITqE0',
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => custom_auth.AuthBloc(secureStorage)
            ..add(custom_auth.AppStarted()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<custom_auth.AuthBloc, custom_auth.AuthState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'MovilizaT',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(context),
            routerConfig: appRouter(state),
          );
          // if (state is AuthAuthenticated) {
          //   return const HomeScreen();
          // } else if (state is AuthUnauthenticated) {
          //   return const LoginScreen();
          // } else {
          //   return const Scaffold(
          //     body: Center(child: CircularProgressIndicator()),
          //   );
          // }
        },
      ),
      // home: const Text("LOGINx"),
    );
  }
}
