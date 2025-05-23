import 'package:go_router/go_router.dart';
import 'package:hola_mundo/views/Auth/login_page.dart';
import 'package:hola_mundo/views/Auth/register_page.dart';
import 'package:hola_mundo/views/categorias/categorias_create_view.dart';
import 'package:hola_mundo/views/categorias/categorias_edit_view.dart';
import 'package:hola_mundo/views/categorias/categorias_list_view.dart';
import 'package:hola_mundo/views/home_page.dart';
import 'package:hola_mundo/views/new_plant_view.dart';
import 'package:hola_mundo/views/plants_view.dart';
import 'package:hola_mundo/views/status_view.dart';



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
    GoRoute(
      path: '/categorias',
      name: 'categorias',
      builder: (_, __) => const CategoriasListView(),
    ),
    GoRoute(
      path: '/categorias/create',
      builder: (context, state) => const CategoriasCreateView(),
    ),
    GoRoute(
      path: '/categorias/edit/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return CategoriasEditView(id: id);
      },
    ),
  ],
);
