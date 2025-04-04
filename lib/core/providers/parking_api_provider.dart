// lib/data/providers/parking_api_provider.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movilizat/core/data/models/parking.dart';

class ParkingApiProvider {
  final String baseUrl =
      'https://tu-api-de-parqueos.com/api'; // Reemplaza con tu API real

  Future<List<Parking>> fetchNearbyParkings(
      double latitude, double longitude, double radius) async {
    // Para desarrollo, podemos usar datos ficticios de La Paz
    // En producción, conectar con una API real

    // Simulación de respuesta de API para desarrollo
    await Future.delayed(Duration(seconds: 1)); // Simular latencia de red

    // Datos de ejemplo para La Paz, Bolivia
    final List<Map<String, dynamic>> mockData = [
      {
        'id': '1',
        'name': 'Parqueo Central',
        'address': 'Av. 16 de Julio, La Paz',
        'latitude': -16.495598,
        'longitude': -68.132286,
        'availableSpots': 15,
        'pricePerHour': 5.0,
        'imageUrl': 'https://example.com/parking1.jpg',
        'isOpen': true,
        'services': ['Seguridad', 'Lavado'],
        'rating': 4.5,
      },
      {
        'id': '2',
        'name': 'Parqueo Sopocachi',
        'address': 'Calle Méndez Arcos, Sopocachi',
        'latitude': -16.508983,
        'longitude': -68.126874,
        'availableSpots': 8,
        'pricePerHour': 4.0,
        'imageUrl': 'https://example.com/parking2.jpg',
        'isOpen': true,
        'services': ['Seguridad', '24 Horas'],
        'rating': 4.2,
      },
      {
        'id': '3',
        'name': 'Parqueo San Pedro',
        'address': 'Calle Colombia, San Pedro',
        'latitude': -16.503321,
        'longitude': -68.138177,
        'availableSpots': 3,
        'pricePerHour': 3.5,
        'imageUrl': 'https://example.com/parking3.jpg',
        'isOpen': true,
        'services': ['Seguridad'],
        'rating': 3.8,
      },
      {
        'id': '4',
        'name': 'Parqueo Zona Sur',
        'address': 'Calle 21, Calacoto',
        'latitude': -16.535253,
        'longitude': -68.086805,
        'availableSpots': 20,
        'pricePerHour': 6.0,
        'imageUrl': 'https://example.com/parking4.jpg',
        'isOpen': true,
        'services': ['Seguridad', 'Lavado', 'Cafetería'],
        'rating': 4.7,
      },
    ];

    return mockData.map((json) => Parking.fromJson(json)).toList();
  }

  Future<Parking> fetchParkingDetails(String parkingId) async {
    // Implementar para obtener detalles específicos de un parqueo
    // Por ahora, retornamos datos de ejemplo
    await Future.delayed(Duration(seconds: 1));

    final Map<String, dynamic> mockData = {
      'id': parkingId,
      'name': 'Parqueo Central',
      'address': 'Av. 16 de Julio, La Paz',
      'latitude': -16.495598,
      'longitude': -68.132286,
      'availableSpots': 15,
      'pricePerHour': 5.0,
      'imageUrl': 'https://example.com/parking1.jpg',
      'isOpen': true,
      'services': ['Seguridad', 'Lavado'],
      'rating': 4.5,
    };

    return Parking.fromJson(mockData);
  }

  // En una versión real, implementar métodos para:
  // - Conectar con una API
  // - Gestionar tokens de autenticación
  // - Manejar errores de red
}
