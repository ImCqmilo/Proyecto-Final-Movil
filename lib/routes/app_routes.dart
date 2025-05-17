import 'package:go_router/go_router.dart';
import 'package:hola_mundo/views/home_page.dart';
import 'package:hola_mundo/views/Auth/login_page.dart';
import 'package:hola_mundo/views/Auth/register_page.dart';
import 'package:hola_mundo/views/plants_view.dart';
import 'package:hola_mundo/views/new_plant_view.dart';
import 'package:hola_mundo/views/status_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/homepage',
  routes: [
    GoRoute(
      path: '/homepage',
      name: 'homepage',
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
    GoRoute(
      path: '/plants',
      name: 'plants',
      builder: (context, state) => const PlantsView(),
    ),
    GoRoute(
      path: '/new-plant',
      name: 'newPlant',
      builder: (context, state) => const NewPlantView(),
    ),
    GoRoute(
      path: '/status',
      name: 'status',
      builder: (context, state) => const StatusView(),
    ),
  ],
);
