import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movilizat/core/data/models/fuel_station.dart';
import 'package:movilizat/core/utils/maps/cached_tiles_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista para almacenar las estaciones de combustible
  List<FuelStation> fuelStations = [];
  late CacheManager _mapCacheManager;
  late MapController _mapController;

  // Variable para manejar el estado de carga
  bool _isLoading = true;
  bool _isLoadingMap = true;

  @override
  void initState() {
    super.initState();
    _initializeCacheManager();
    _fetchFuelStations();
    _mapController = MapController();
  }

  @override
  void dispose() {
    super.dispose();
    if (!_isLoadingMap) {
      _mapCacheManager.dispose();
    }
  }

  Future<void> _initializeCacheManager() async {
    try {
      // Obtener directorio temporal de manera segura
      final tempDir = await getTemporaryDirectory();

      // Crear el CacheManager
      _mapCacheManager = CacheManager(
        Config(
          'map_tiles_cache',
          stalePeriod: const Duration(days: 7),
          maxNrOfCacheObjects: 200,
          fileSystem: IOFileSystem(tempDir.path),
        ),
      );

      // Actualizar estado cuando se complete la inicialización
      setState(() {
        _isLoadingMap = false;
      });
    } catch (e) {
      // Manejar cualquier error de inicialización
      print('Error inicializando CacheManager: $e');
      setState(() {
        _isLoadingMap = false;
      });
    }
  }

  Future<void> _fetchFuelStations() async {
    try {
      // Obtener la instancia de Supabase
      final supabase = Supabase.instance.client;
      // Consultar todos los registros de la tabla fuelstation
      final response = await supabase.from('fuelstation').select();

      setState(() {
        // Convertir la respuesta a una lista de mapas
        fuelStations =
            response.map((station) => FuelStation.fromJson(station)).toList();
      });
    } catch (error) {
      // Manejar cualquier error de consulta

      print('Error al cargar las estaciones de combustible: $error');

      // Opcional: mostrar un mensaje de error al usuario
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
    if (_isLoadingMap) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: const LatLng(-16.5217103519189, -68.1572745228186),
          initialZoom: 10.0,
          minZoom: 3,
          maxZoom: 18,
          // Callback para eventos de mapa
          onMapEvent: (mapEvent) {
            // Puedes manejar eventos como zoom, movimiento, etc.
            // print('Evento de mapa: ${mapEvent.camera.center}');
          },
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c', 'd'],
            maxZoom: 18,
            // Usar proveedor de tiles personalizado, para mejorar la velocidad
            tileProvider: MyCachedTileProvider(cacheManager: _mapCacheManager),
            // Mejora de rendimiento
            keepBuffer: 5,
          ),

          // Resto de capas como en el ejemplo anterior
          const MarkerLayer(
            markers: [
              Marker(
                point: LatLng(-16.549265841807, -68.2047145507413),
                width: 60,
                height: 60,
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
