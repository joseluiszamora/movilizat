part of 'parking_bloc.dart';

abstract class ParkingState extends Equatable {
  const ParkingState();

  @override
  List<Object> get props => [];
}

class ParkingInitial extends ParkingState {}

class ParkingLoading extends ParkingState {}

class ParkingsLoaded extends ParkingState {
  final List<Parking> parkings;

  const ParkingsLoaded(this.parkings);

  @override
  List<Object> get props => [parkings];
}

class ParkingDetailLoaded extends ParkingState {
  final Parking parking;

  const ParkingDetailLoaded(this.parking);

  @override
  List<Object> get props => [parking];
}

class ParkingError extends ParkingState {
  final String message;

  const ParkingError(this.message);

  @override
  List<Object> get props => [message];
}
