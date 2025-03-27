import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movilizat/core/data/models/fuel_station.dart';
import 'package:movilizat/core/routes/app_routes.dart';
import 'package:movilizat/views/fuel/components/product_station_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FuelPage extends StatefulWidget {
  const FuelPage({super.key});

  @override
  State<FuelPage> createState() => _FuelPageState();
}

class _FuelPageState extends State<FuelPage> {
  List<FuelStation> fuelStations = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFuelStations();
  }

  Future<void> _fetchFuelStations() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.from('fuelstation').select();

      setState(() {
        fuelStations =
            response.map((station) => FuelStation.fromJson(station)).toList();
      });
    } catch (error) {
      print('Error al cargar las estaciones de combustible: $error');

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No se pudieron cargar las estaciones')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Estaciones de Servicio'),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : fuelStations.isEmpty
                  ? const Center(child: Text('No hay estaciones disponibles'))
                  : ListView.builder(
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                // Center(
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceAround,
                                //     children: [
                                //       ...station.productos.map((producto) =>
                                //           ProductStationInfo(
                                //               producto: producto)),
                                //     ],
                                //   ),
                                // ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            station.direccion,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          const SizedBox(height: 10),
                                          ElevatedButton(
                                            onPressed: () {
                                              context.go(
                                                  AppRoutes.fuelStationPage);
                                            },
                                            child:
                                                const Text("Mas Información"),
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
