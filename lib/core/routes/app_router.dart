import 'package:go_router/go_router.dart';
import 'package:movilizat/core/blocs/auth/auth_bloc.dart';
import 'package:movilizat/core/routes/app_routes.dart';
import 'package:movilizat/views/auth/login_screen.dart';
import 'package:movilizat/views/home/home_screen.dart';
import 'package:movilizat/views/splash/splash_page.dart';

GoRouter appRouter(AuthState authState) => GoRouter(
      initialLocation: AppRoutes.splash,
      routes: publicRoutes(),
      redirect: (context, state) {
        // Si el usuario está autenticado, redirigir a navigation
        if (authState is AuthAuthenticated) {
          return AppRoutes.navigation;
        }
        // Si el usuario NO está autenticado, redirigir a login
        if (authState is AuthUnauthenticated) {
          return AppRoutes.authLogin;
        }

        // No hay redirección
        return null;
      },
    );

List<RouteBase> publicRoutes() => [
      /* <---- AUTH -----> */
      GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => const SplashPage()),
      GoRoute(
          path: AppRoutes.navigation,
          builder: (context, state) => const HomeScreen()),
      GoRoute(
          path: AppRoutes.authLogin,
          builder: (context, state) => const LoginScreen()),
    ];
