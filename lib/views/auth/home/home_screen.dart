import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movilizat/core/blocs/auth/auth_bloc.dart';
import 'package:movilizat/views/auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
          )
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()));
          }
        },
        child: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Bienvenido: ${state.email}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(SignOutRequested());
                        },
                        child: const Text('Cerrar Sesión'))
                  ],
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
