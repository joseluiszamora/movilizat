import 'package:equatable/equatable.dart';

class FuelProduct extends Equatable {
  final int id;
  final String nombre;
  final int tiempoEspera;
  final int autosEnFila;
  final int combustibleRestante;
  final DateTime actualizadoEn;

  const FuelProduct({
    required this.id,
    required this.nombre,
    required this.tiempoEspera,
    required this.autosEnFila,
    required this.combustibleRestante,
    required this.actualizadoEn,
  });

  factory FuelProduct.fromJson(Map<String, dynamic> json) {
    return FuelProduct(
      id: json['id'],
      nombre: json['name'],
      tiempoEspera: 9,
      autosEnFila: 19,
      combustibleRestante: 29,
      actualizadoEn: DateTime.parse(json['updated_at']),
    );
    // return FuelProduct(
    //   id: json['id'],
    //   nombre: json['name'],
    //   tiempoEspera: int.parse(json['wait_time']),
    //   autosEnFila: int.parse(json['wait_cars']),
    //   combustibleRestante: int.parse(json['remaining_fuel']),
    //   actualizadoEn: DateTime(json['updated_at']),
    // );
  }

  @override
  List<Object> get props => [
        id,
        nombre,
        tiempoEspera,
        autosEnFila,
        combustibleRestante,
        actualizadoEn
      ];
}
