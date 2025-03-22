import 'package:flutter/material.dart';
import 'package:flutter_the_rick_and_morty/main.dart';
import 'package:flutter_the_rick_and_morty/src/models/personajes.dart';
import 'package:flutter_the_rick_and_morty/src/screens/detalle_personaje_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/personajes',
  routes: [
    GoRoute(
      path: '/personajes',
      name: 'personajes',
      builder: (context, settings) => PersonajesScreen(),
      routes: [
        GoRoute(
          path: 'detalle',
          name: 'detalle-personajes',
          builder: (BuildContext context, GoRouterState settings) {

            final extras = settings.extra as Personajes;

            return DetallePersonajeScreen(
              personaje: extras,
            );
          },
        )
      ],
    ),
  ],
);