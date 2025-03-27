import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:movilizat/core/data/models/fuel_station.dart';
import 'package:movilizat/views/maps/osm_map.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FuelStation> fuelStations = [];
  List<Marker> markers = [];
  bool _isLoading = true;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _fetchFuelStations();
  }

  Future<void> _fetchFuelStations() async {
    try {
      final supabase = Supabase.instance.client;
      // final response = await supabase.from('fuelstation').select();
      final response =
          await supabase.from('fuelstation').select('*, fuelproduct(*)');

      List<Marker> markersTmp = [];

      // Convertir response a FuelStations
      fuelStations =
          response.map((station) => FuelStation.fromJson(station)).toList();

      // Convertir las FuelStations a Markers
      for (var station in fuelStations) {
        markersTmp.add(markerFromFuelStation(station));
      }

      setState(() {
        markers = markersTmp;
      });
    } catch (error) {
      print('Error al cargar las estaciones de combustible: $error');
      setState(() {
        _showError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showError) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No se pudieron cargar las estaciones')));
    }

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        const Text("data Home"),
        Expanded(
            child: OsmMap(
          pointCenter: const LatLng(-16.549265841807, -68.2047145507413),
          markers: markers,
        )),
      ],
    );
  }

  // Convertir el FuelStation a Marker con dialog
  Marker markerFromFuelStation(FuelStation station) => Marker(
        width: 60.0,
        height: 60.0,
        point: LatLng(station.latitud, station.longitud),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(station.nombre),
                content: SizedBox(
                  width: double.maxFinite,
                  height: 300,
                  child: Column(
                    children: [
                      Text(station.direccion),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: station.productos.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Row(children: [
                              Text(station.productos[index].nombre)
                            ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Chip(
                                  avatar: const Icon(Icons.time_to_leave),
                                  label: Text(station
                                      .productos[index].autosEnFila
                                      .toString()),
                                ),
                                Chip(
                                  avatar: const Icon(Icons.access_time_sharp),
                                  label: Text(station
                                      .productos[index].tiempoEspera
                                      .toString()),
                                ),
                                Chip(
                                  avatar: const Icon(Icons.local_gas_station),
                                  label: Text(station
                                      .productos[index].combustibleRestante
                                      .toString()),
                                )
                              ],
                            ),
                            Row(children: [
                              Text(
                                  'Actualizado en: ${DateFormat('yyyy-MM-dd – kk:mm').format(station.productos[index].actualizadoEn)}')
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cerrar'),
                  ),
                ],
              ),
            );
          },
          child: Column(
            children: [
              Icon(
                Icons.location_pin,
                color: station.isActive ? Colors.green : Colors.red,
                size: 40.0,
              ),
            ],
          ),
        ),
      );
}
