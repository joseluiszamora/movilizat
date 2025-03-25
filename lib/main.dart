import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movilizat/core/blocs/auth/auth_bloc.dart';
import 'package:movilizat/views/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //     apiKey: 'AIzaSyD-9tSrZJ2Jj5JY1b2eQ8Jk1W9J2J9J2J9',
      //     authDomain: 'movilizaT.firebaseapp.com',
      //     projectId: 'movilizaT')
      ); // Inicializar Firebase

  runApp(BlocProvider(
    create: (context) => AuthBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovilizaT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      // home: const Text("LOGINx"),
    );
  }
}
