import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movilizat/views/parking/info_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:movilizat/core/blocs/parking/parking_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingDetailScreen extends StatefulWidget {
  final String parkingId;
  const ParkingDetailScreen({super.key, required this.parkingId});

  @override
  State<ParkingDetailScreen> createState() => _ParkingDetailScreenState();
}

class _ParkingDetailScreenState extends State<ParkingDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ParkingBloc>().add(LoadParkingDetails(widget.parkingId));
  }

  Future<void> _openMaps(double lat, double lng, String label) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&destination_place_id=$label';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir el mapa')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ParkingBloc, ParkingState>(
      builder: (context, state) {
        if (state is ParkingLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ParkingDetailLoaded) {
          final parking = state.parking;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(parking.name),
                  background: Image.network(
                    parking.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 50),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: parking.isOpen ? Colors.green : Colors.red,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              parking.isOpen ? 'Abierto' : 'Cerrado',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                index < parking.rating.floor()
                                    ? Icons.star
                                    : index < parking.rating
                                        ? Icons.star_half
                                        : Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${parking.rating})',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              parking.address,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.directions,
                                color: Colors.blue),
                            onPressed: () {
                              _openMaps(
                                parking.latitude,
                                parking.longitude,
                                parking.name,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InfoCard(
                            icon: Icons.attach_money,
                            title: 'Precio',
                            subtitle: 'Bs. ${parking.pricePerHour}/hora',
                            color: Colors.green,
                          ),
                          InfoCard(
                            icon: Icons.local_parking,
                            title: 'Espacios',
                            subtitle: '${parking.availableSpots} disponibles',
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Servicios',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: parking.services.map((service) {
                          return Chip(
                            label: Text(service),
                            backgroundColor: Colors.blue.shade100,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Ubicación',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target:
                                  LatLng(parking.latitude, parking.longitude),
                              zoom: 16,
                            ),
                            markers: {
                              Marker(
                                markerId: MarkerId(parking.id),
                                position:
                                    LatLng(parking.latitude, parking.longitude),
                                infoWindow: InfoWindow(title: parking.name),
                              ),
                            },
                            myLocationEnabled: true,
                            zoomControlsEnabled: false,
                            mapToolbarEnabled: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        if (state is ParkingError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.message}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<ParkingBloc>()
                        .add(LoadParkingDetails(widget.parkingId));
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }
        return Text("data");
      },
    ));
  }
}
