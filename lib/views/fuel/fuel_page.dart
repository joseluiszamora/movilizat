import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movilizat/core/data/models/fuel_station.dart';
import 'package:movilizat/core/routes/app_routes.dart';
import 'package:movilizat/views/fuel/components/product_station_info.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FuelPage extends StatelessWidget {
  const FuelPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<FuelStation> fuelStations = FuelStation.stationsList;
    return Column(
      children: [
        const Text('Estaciones de Servicio'),
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.fromLTRB(
            16.0,
            0,
            16.0,
            16.0,
          ),
          color: const Color(0xFF00BF6D),
          child: Form(
            child: TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                // search
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search,
                  color: const Color(0xFF1D1D35).withOpacity(0.64),
                ),
                hintText: "Search",
                hintStyle: TextStyle(
                  color: const Color(0xFF1D1D35).withOpacity(0.64),
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0 * 1.5, vertical: 16.0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          ),
        ),
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
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ...station.productos.map((producto) =>
                                  ProductStationInfo(producto: producto)),
                            ],
                          ),
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
                                  ElevatedButton(
                                    onPressed: () {
                                      context.go(AppRoutes.fuelStationPage);
                                    },
                                    child: const Text("Mas Información"),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
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
}
