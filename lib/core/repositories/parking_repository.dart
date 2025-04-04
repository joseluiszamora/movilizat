import 'package:movilizat/core/data/models/parking.dart';
import 'package:movilizat/core/providers/parking_api_provider.dart';

class ParkingRepository {
  final ParkingApiProvider _apiProvider;

  ParkingRepository(this._apiProvider);

  Future<List<Parking>> getNearbyParkings(
      double latitude, double longitude, double radius) async {
    try {
      return await _apiProvider.fetchNearbyParkings(
          latitude, longitude, radius);
    } catch (e) {
      throw Exception('Error al obtener parqueos cercanos: $e');
    }
  }

  Future<Parking> getParkingDetails(String parkingId) async {
    try {
      return await _apiProvider.fetchParkingDetails(parkingId);
    } catch (e) {
      throw Exception('Error al obtener detalles del parqueo: $e');
    }
  }

  // Agregar más métodos según sea necesario
}
