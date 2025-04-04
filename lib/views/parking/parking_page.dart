import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:movilizat/core/blocs/parking/parking_bloc.dart';
import 'package:movilizat/core/data/models/filter_options.dart';
import 'package:movilizat/core/data/models/parking.dart';
import 'package:movilizat/views/parking/filter_screen.dart';
import 'package:movilizat/views/parking/parking_card.dart';
import 'package:movilizat/views/parking/parking_detail_screen.dart';

class ParkingPage extends StatefulWidget {
  const ParkingPage({super.key});

  @override
  State<ParkingPage> createState() => _ParkingPageState();
}

class _ParkingPageState extends State<ParkingPage> {
  gmaps.GoogleMapController? _mapController;
  Set<gmaps.Marker> _markers = {};
  gmaps.LatLng _currentPosition = const gmaps.LatLng(
      -16.489689, -68.119293); // Centro de La Paz por defecto
  FilterOptions _filterOptions = FilterOptions(
    maxPrice: 10.0,
    minAvailableSpots: 0,
    maxDistance: 1.0,
    services: [],
    minRating: 0.0,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si los servicios de ubicación están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Por favor habilita los servicios de ubicación')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Los permisos de ubicación fueron denegados')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Los permisos de ubicación están permanentemente denegados')),
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = gmaps.LatLng(position.latitude, position.longitude);
      });

      // Cargar parqueos cercanos
      context.read<ParkingBloc>().add(LoadNearbyParkings(
            latitude: position.latitude,
            longitude: position.longitude,
            radius: _filterOptions.maxDistance,
            filterOptions: _filterOptions,
          ));

      // Mover cámara a la posición actual
      _mapController?.animateCamera(
          gmaps.CameraUpdate.newLatLngZoom(_currentPosition, 15));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener la ubicación: $e')),
      );
    }
  }

  void _addParkingMarkers(List<Parking> parkings) {
    Set<gmaps.Marker> markers = {};

    for (var parking in parkings) {
      final gmaps.LatLng position =
          gmaps.LatLng(parking.latitude, parking.longitude);
      final marker = gmaps.Marker(
        markerId: gmaps.MarkerId(parking.id),
        position: position,
        infoWindow: gmaps.InfoWindow(
          title: parking.name,
          snippet:
              'Espacios: ${parking.availableSpots} - Bs. ${parking.pricePerHour}/hora',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ParkingDetailScreen(parkingId: parking.id),
              ),
            );
          },
        ),
        icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(
          parking.availableSpots > 0
              ? gmaps.BitmapDescriptor.hueGreen
              : gmaps.BitmapDescriptor.hueRed,
        ),
      );

      markers.add(marker);
    }

    setState(() {
      _markers = markers;
    });
  }

  Future<void> _openFilterScreen() async {
    final result = await Navigator.push<FilterOptions>(
      context,
      MaterialPageRoute(
        builder: (context) => FilterScreen(initialFilters: _filterOptions),
      ),
    );

    if (result != null) {
      setState(() {
        _filterOptions = result;
      });

      // Aplicar nuevos filtros
      context.read<ParkingBloc>().add(FilterParkings(_filterOptions));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parqueos La Paz'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _openFilterScreen,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getCurrentLocation();
            },
          ),
        ],
      ),
      body: BlocConsumer<ParkingBloc, ParkingState>(
        listener: (context, state) {
          if (state is ParkingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ParkingsLoaded) {
            _addParkingMarkers(state.parkings);
          }

          return Stack(
            children: [
              gmaps.GoogleMap(
                initialCameraPosition: gmaps.CameraPosition(
                  target: _currentPosition,
                  zoom: 15,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: _markers,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
              ),
              if (state is ParkingLoading)
                Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Buscar parqueos en La Paz',
                              border: InputBorder.none,
                            ),
                            onTap: () {
                              // Implementar búsqueda en el futuro
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Container(
                  height: 120,
                  child: state is ParkingsLoaded
                      ? state.parkings.isEmpty
                          ? Center(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'No se encontraron parqueos con los filtros actuales',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.parkings.length,
                              itemBuilder: (context, index) {
                                final parking = state.parkings[index];
                                return ParkingCard(
                                  parking: parking,
                                  onTap: () {
                                    _mapController?.animateCamera(
                                      gmaps.CameraUpdate.newLatLngZoom(
                                        gmaps.LatLng(parking.latitude,
                                            parking.longitude),
                                        17,
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                      : Center(
                          child: Text('Busca parqueos cercanos'),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
