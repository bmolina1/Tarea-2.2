// lib/src/provider/personajes_provider.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_the_rick_and_morty/src/models/personajes.dart';

class PersonajesProvider {
  Future<List<Personajes>> obtenerPersonajes() async {
    final url = Uri.parse('https://rickandmortyapi.com/api/character');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<Personajes> personajes = List<Personajes>.from(
          data['results'].map(
            (item) => Personajes.fromJson(item),
          ),
        );

        return personajes;
      } else {

        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener personajes: $e');
    }
  }
}
