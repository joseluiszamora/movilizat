import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movilizat/core/data/models/filter_options.dart';
import 'package:movilizat/core/data/models/parking.dart';
import 'package:movilizat/core/repositories/parking_repository.dart';

part 'parking_event.dart';
part 'parking_state.dart';

class ParkingBloc extends Bloc<ParkingEvent, ParkingState> {
  final ParkingRepository _parkingRepository;
  List<Parking> _loadedParkings = [];
  FilterOptions? _lastAppliedFilters;

  ParkingBloc(this._parkingRepository) : super(ParkingInitial()) {
    on<LoadNearbyParkings>(_onLoadNearbyParkings);
    on<LoadParkingDetails>(_onLoadParkingDetails);
    on<FilterParkings>(_onFilterParkings);
  }

  Future<void> _onLoadNearbyParkings(
    LoadNearbyParkings event,
    Emitter<ParkingState> emit,
  ) async {
    emit(ParkingLoading());
    try {
      final parkings = await _parkingRepository.getNearbyParkings(
        event.latitude,
        event.longitude,
        event.radius,
      );

      _loadedParkings = parkings;
      _lastAppliedFilters = event.filterOptions;

      // Aplicar filtros si se proporcionan
      if (event.filterOptions != null) {
        final filteredParkings = _applyFilters(parkings, event.filterOptions!);
        emit(ParkingsLoaded(filteredParkings));
      } else {
        emit(ParkingsLoaded(parkings));
      }
    } catch (e) {
      emit(ParkingError(e.toString()));
    }
  }

  Future<void> _onLoadParkingDetails(
    LoadParkingDetails event,
    Emitter<ParkingState> emit,
  ) async {
    emit(ParkingLoading());
    try {
      final parking =
          await _parkingRepository.getParkingDetails(event.parkingId);
      emit(ParkingDetailLoaded(parking));
    } catch (e) {
      emit(ParkingError(e.toString()));
    }
  }

  void _onFilterParkings(
    FilterParkings event,
    Emitter<ParkingState> emit,
  ) {
    _lastAppliedFilters = event.filterOptions;
    final filteredParkings =
        _applyFilters(_loadedParkings, event.filterOptions);
    emit(ParkingsLoaded(filteredParkings));
  }

  List<Parking> _applyFilters(List<Parking> parkings, FilterOptions filters) {
    return parkings.where((parking) {
      // Filtrar por precio
      if (parking.pricePerHour > filters.maxPrice) {
        return false;
      }

      // Filtrar por espacios disponibles
      if (parking.availableSpots < filters.minAvailableSpots) {
        return false;
      }

      // Filtrar por calificación
      if (parking.rating < filters.minRating) {
        return false;
      }

      // Filtrar por servicios
      if (filters.services.isNotEmpty) {
        // Verificar si todos los servicios seleccionados están en el parqueo
        final hasAllSelectedServices = filters.services.every(
          (service) => parking.services.contains(service),
        );
        if (!hasAllSelectedServices) {
          return false;
        }
      }

      return true;
    }).toList();
  }
}
