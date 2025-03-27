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
      final response = await supabase.from('fuelstation').select();

      List<Marker> markersTmp = [];

      fuelStations =
          response.map((station) => FuelStation.fromJson(station)).toList();

      for (var element in fuelStations) {
        markersTmp.add(Marker(
          width: 60.0,
          height: 60.0,
          point: LatLng(element.latitud, element.longitud),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(element.nombre),
                  content: Text(element.direccion),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
            child: const Column(
              children: [
                Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40.0,
                ),
              ],
            ),
          ),
        ));
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
}
