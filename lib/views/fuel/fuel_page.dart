import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movilizat/core/data/models/fuel_station.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FuelPage extends StatelessWidget {
  const FuelPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<FuelStation> fuelStations = FuelStation.stationsList;
    return Column(
      children: [
        const Text('Estaciones de Servicio'),
        Expanded(
          child: ListView.builder(
              itemCount: fuelStations.length,
              itemBuilder: (context, index) {
                final station = fuelStations[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          station.nombre,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Imagen en miniatura
                            CachedNetworkImage(
                              imageUrl: station.imagen,
                              // imageUrl: 'http://cbhenews.cbhe.org.bo/?p=1233',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    station.direccion,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      await openGoogleMaps(context, station);
                                    },
                                    icon: const Icon(Icons.map),
                                    label: const Text('Ver en Mapa'),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ...station.productos.map(
                                  (producto) => ProductChip(product: producto)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  Future<void> openGoogleMaps(BuildContext context, FuelStation station) async {
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=${station.latitud},${station.longitud}';

    if (await canLaunchUrlString(googleMapsUrl)) {
      await launchUrlString(googleMapsUrl);
    } else {
      throw 'No se pudo abrir Google Maps';
    }
  }
}

class ProductChip extends StatelessWidget {
  const ProductChip({
    super.key,
    required this.product,
  });

  final String product;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.blue;
    if (product == 'gasolina') {
      color = Colors.blue;
    } else if (product == 'diesel') {
      color = Colors.red;
    } else if (product == 'gnv') {
      color = Colors.green;
    }
    return ChoiceChip(
      label: Text(product),
      onSelected: (selected) {},
      selected: true,
      pressElevation: 0,
      selectedColor: color,
      labelStyle: const TextStyle(color: Colors.white),
      backgroundColor: Colors.grey,
    );
  }
}
