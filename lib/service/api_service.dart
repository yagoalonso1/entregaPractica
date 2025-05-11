import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/character.dart';

// Esta clase se encarga de comunicarse con la API de Harry Potter
class ApiService {
  // URL base de la API de Harry Potter
  final String baseUrl = 'https://hp-api.onrender.com/api';

  // Método que obtiene todos los personajes de la API
  // Devuelve una lista de objetos Character
  Future<List<Character>> getCharacters() async {
    try {
      // Realiza una petición GET a la URL de los personajes
      final response = await http.get(Uri.parse('$baseUrl/characters'));

      // Si la respuesta es exitosa (código 200)
      if (response.statusCode == 200) {
        // Decodifica el cuerpo de la respuesta (JSON) a una lista dinámica
        final List<dynamic> jsonData = json.decode(response.body);
        // Convierte cada elemento de la lista en un objeto Character
        return jsonData.map((data) => Character.fromJson(data)).toList();
      } else {
        // Si la respuesta no es exitosa, lanza una excepción con el código de error
        throw Exception('Error al cargar personajes: ${response.statusCode}');
      }
    } catch (e) {
      // Si ocurre algún error de conexión o de otro tipo, lanza una excepción
      throw Exception('Error de conexión: $e');
    }
  }
}
