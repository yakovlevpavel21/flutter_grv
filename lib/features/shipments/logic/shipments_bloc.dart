import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/shipments/data/mappers/shipment_mapper.dart';
import 'package:grv/features/shipments/data/models/shipment_item.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/data/repos/shipments_repo.dart';

part "shipments_event.dart"; 
part "shipments_state.dart"; 

class ShipmentsBloc extends Bloc<ShipmentsEvent, ShipmentsState> {
  final ShipmentsRepository repository;

  ShipmentsBloc(this.repository) : super(ShipmentsLoading()) {
    on<LoadShipments>(_load);
    on<ShipmentsTypeChanged>(_onTypeChanged);
  }

  Future<void> _load(LoadShipments event, Emitter<ShipmentsState> emit) async {
    try {
      emit(ShipmentsLoading());
      final shipments = await repository.fetchShipments();
      final items = shipments.map((s) => s.toShipmentUi()).toList();
      emit(
        ShipmentsLoaded(
          items: items, 
          selectedType: ShipmentType.shipment, 
          hasActiveFilters: false
        )
      );
    } catch (e) {
      emit(ShipmentsError(e.toString()));
    }
  }

  void _onTypeChanged(
    ShipmentsTypeChanged event,
    Emitter<ShipmentsState> emit,
  ) {
    if (state is! ShipmentsLoaded) return;

    final current = state as ShipmentsLoaded;

    emit(
      current.copyWith(
        selectedType: event.type,
      ),
    );
  }
}


extension on ShipmentsLoaded {
  ShipmentsLoaded copyWith({
    List<ShipmentItemUi>? items,
    ShipmentType? selectedType,
    bool? hasActiveFilters,
  }) {
    return ShipmentsLoaded(
      items: items ?? this.items,
      selectedType: selectedType ?? this.selectedType,
      hasActiveFilters:
          hasActiveFilters ?? this.hasActiveFilters,
    );
  }
}