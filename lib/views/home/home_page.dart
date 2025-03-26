import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movilizat/core/data/models/fuel_station.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

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

  // Variable para manejar el estado de carga
  bool _isLoading = true;
  bool _isLoadingMap = true;

  @override
  void initState() {
    super.initState();
    _initializeCacheManager();
    _fetchFuelStations();
  }

  @override
  void dispose() {
    _mapCacheManager.dispose();
    super.dispose();
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
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(-16.5217103519189, -68.1572745228186),
        initialZoom: 10.0,
        minZoom: 3,
        maxZoom: 18,
      ),
      children: [
        TileLayer(
          urlTemplate:
              "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c', 'd'],
          maxZoom: 18,

          // Usar proveedor de tiles personalizado
          tileProvider: MyCachedTileProvider(
            cacheManager: _mapCacheManager,
          ),

          // Mejora de rendimiento
          keepBuffer: 5,

          // backgroundColor: Colors.white,

          // Placeholder mientras carga
          // placeholderBuilder: (context) =>
          //   Center(child: CircularProgressIndicator()),
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
    );
  }
}

// Proveedor de Tiles con Caché Personalizado
class MyCachedTileProvider extends NetworkTileProvider {
  final CacheManager cacheManager;

  MyCachedTileProvider({required this.cacheManager});

  @override
  Future<Uint8List> loadTileBytes(String url) async {
    try {
      // Intentar obtener archivo de caché
      FileInfo? fileInfo = await cacheManager.getFileFromCache(url);

      if (fileInfo != null && fileInfo.file.existsSync()) {
        // Si está en caché, devolver bytes del archivo
        return await fileInfo.file.readAsBytes();
      }

      // Si no está en caché, descargar y guardar
      FileInfo newFileInfo = await cacheManager.downloadFile(url);
      return await newFileInfo.file.readAsBytes();
    } catch (e) {
      print('Error cargando tile: $e');

      // Fallback a descarga directa si hay problemas
      final response = await http.get(Uri.parse(url));
      return response.bodyBytes;
    }
  }
}
