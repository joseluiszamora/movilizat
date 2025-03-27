import 'package:equatable/equatable.dart';
import 'package:movilizat/core/data/models/fuel_product.dart';

class FuelStation extends Equatable {
  final int id;
  final String nombre;
  final String direccion;
  final double latitud;
  final double longitud;
  final List<FuelProduct> productos;
  final String imagen;
  final bool isActive;

  const FuelStation({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.latitud,
    required this.longitud,
    required this.productos,
    required this.imagen,
    required this.isActive,
  });

  factory FuelStation.fromJson(Map<String, dynamic> json) {
    return FuelStation(
      id: json['id'],
      nombre: json['name'],
      direccion: json['address'],
      latitud: json['latitude'],
      longitud: json['longitude'],
      productos: (json['fuelproduct'] as List?)
              ?.map((productJson) => FuelProduct.fromJson(productJson))
              .toList() ??
          [],
      imagen: json['image'],
      isActive: json['active'],
    );
  }

  @override
  List<Object> get props =>
      [id, nombre, direccion, latitud, longitud, productos, imagen];

  static List<FuelStation> stationsList = [
    const FuelStation(
        id: 1,
        nombre: "Estación de Servicio Satélite GNV S.R.L.",
        direccion: "Avenida Cívica N° 78 - Ciudad El Alto, La Paz",
        latitud: -16.5033,
        longitud: -68.1625,
        productos: [],
        imagen:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVriUJlkvPVgX8lqYokR0lOn73Ijhx7DOmVA&s",
        isActive: false),
  ];
}
