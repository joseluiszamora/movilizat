part of 'parking_bloc.dart';

abstract class ParkingEvent extends Equatable {
  const ParkingEvent();

  @override
  List<Object> get props => [];
}

class LoadNearbyParkings extends ParkingEvent {
  final double latitude;
  final double longitude;
  final double radius;
  final FilterOptions? filterOptions;

  const LoadNearbyParkings({
    required this.latitude,
    required this.longitude,
    this.radius = 1.0,
    this.filterOptions,
  });

  @override
  List<Object> get props =>
      [latitude, longitude, radius, if (filterOptions != null) filterOptions!];
}

class LoadParkingDetails extends ParkingEvent {
  final String parkingId;

  const LoadParkingDetails(this.parkingId);

  @override
  List<Object> get props => [parkingId];
}

class FilterParkings extends ParkingEvent {
  final FilterOptions filterOptions;

  const FilterParkings(this.filterOptions);

  @override
  List<Object> get props => [filterOptions];
}
