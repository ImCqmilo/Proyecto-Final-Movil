import 'package:go_router/go_router.dart';
import 'package:hola_mundo/views/Auth/login_page.dart';
import 'package:hola_mundo/views/Auth/register_page.dart';
import 'package:hola_mundo/views/home_page.dart';



final GoRouter appRouter  = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
  ],
);
