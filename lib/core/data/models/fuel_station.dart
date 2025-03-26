import 'package:equatable/equatable.dart';

class FuelStation extends Equatable {
  final int id;
  final String nombre;
  final String direccion;
  final String latitud;
  final String longitud;
  final List<String> productos;
  final String imagen;

  const FuelStation({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.latitud,
    required this.longitud,
    required this.productos,
    required this.imagen,
  });

  factory FuelStation.fromJson(Map<String, dynamic> json) {
    return FuelStation(
      id: json['id'],
      nombre: json['nombre'],
      direccion: json['direccion'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      productos: List<String>.from(json['productos']),
      imagen: json['imagen'],
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
      latitud: "-16.5033",
      longitud: "-68.1625",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/satelite_gnv.jpg",
    ),
    const FuelStation(
      id: 2,
      nombre: "Estación de Servicio Laredo S.R.L.",
      direccion: "Avenida 6 de Marzo Nº 1962 - El Alto, La Paz",
      latitud: "-16.5112",
      longitud: "-68.1923",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/laredo.jpg",
    ),
    const FuelStation(
      id: 3,
      nombre: "Estación de Servicio Gran Bretaña",
      direccion:
          "Carretera La Paz - Viacha Urb. Villa Bolivar 'F' Mzo. 299, El Alto, La Paz",
      latitud: "-16.5264",
      longitud: "-68.2137",
      productos: ["gasolina", "diesel"],
      imagen: "https://www.anh.gob.bo/estaciones/gran_bretana.jpg",
    ),
    const FuelStation(
      id: 4,
      nombre: "Estación de Servicio San Pedro",
      direccion: "Av. Arce esquina Plaza Isabel La Católica, La Paz",
      latitud: "-16.5125",
      longitud: "-68.1234",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/san_pedro.jpg",
    ),
    const FuelStation(
      id: 5,
      nombre: "Estación de Servicio El Prado",
      direccion: "Av. 16 de Julio Nº 1234, La Paz",
      latitud: "-16.5031",
      longitud: "-68.1315",
      productos: ["gasolina", "diesel"],
      imagen: "https://www.anh.gob.bo/estaciones/el_prado.jpg",
    ),
    const FuelStation(
      id: 6,
      nombre: "Estación de Servicio Cristo Autogas SRL",
      direccion: "Av. Chacaltaya No. 804, Zona Achachicala, La Paz",
      latitud: "-16.5",
      longitud: "-68.15",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/cristo_autogas.jpg",
    ),
    const FuelStation(
      id: 7,
      nombre: "Estación de Servicio Chasquipampa",
      direccion: "Zona Chasquipampa, La Paz",
      latitud: "-16.6",
      longitud: "-68.1333",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/chasquipampa.jpg",
    ),
    const FuelStation(
      id: 8,
      nombre: "Estación de Servicio Kantuta SRL",
      direccion: "Zona Villa Fátima, La Paz",
      latitud: "-16.5",
      longitud: "-68.1167",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/kantuta.jpg",
    ),
    const FuelStation(
      id: 9,
      nombre: "Estación de Servicio Alto Lima SRL",
      direccion: "Av. 6 de Marzo, El Alto, La Paz",
      latitud: "-16.5167",
      longitud: "-68.1667",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/alto_lima.jpg",
    ),
    const FuelStation(
      id: 10,
      nombre: "Estación de Servicio Eduardo Yupanqui Quispe",
      direccion:
          "Carretera La Paz - Copacabana Km. 8, Zona San Roque, El Alto, La Paz",
      latitud: "-16.5",
      longitud: "-68.2",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/eduardo_yupanqui.jpg",
    ),
    const FuelStation(
      id: 11,
      nombre: "Estación de Servicio Apóstol Santiago",
      direccion: "Av. Juan Pablo II, El Alto, La Paz",
      latitud: "-16.5",
      longitud: "-68.15",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/apostol_santiago.jpg",
    ),
    const FuelStation(
      id: 12,
      nombre: "Estación de Servicio Dragón de Oro",
      direccion: "Zona Villa Adela, El Alto, La Paz",
      latitud: "-16.5333",
      longitud: "-68.1833",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/dragon_de_oro.jpg",
    ),
    const FuelStation(
      id: 13,
      nombre: "Estación de Servicio El Paraíso SRL",
      direccion: "Zona Santiago II, El Alto, La Paz",
      latitud: "-16.55",
      longitud: "-68.2",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/el_paraiso.jpg",
    ),
    const FuelStation(
      id: 14,
      nombre: "Estación de Servicio Interoceánica",
      direccion: "Carretera La Paz - Oruro Km. 10, El Alto, La Paz",
      latitud: "-16.5667",
      longitud: "-68.2167",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/interoceanica.jpg",
    ),
    const FuelStation(
      id: 15,
      nombre: "Estación de Servicio Las Rosas SRL",
      direccion: "Zona Villa Esperanza, El Alto, La Paz",
      latitud: "-16.5333",
      longitud: "-68.1667",
      productos: ["gasolina", "diesel", "gnv"],
      imagen: "https://www.anh.gob.bo/estaciones/interoceanica.jpg",
    ),
  ];
}
