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
  List<ShipmentItemUi> _allItems = [];

  ShipmentsBloc(this.repository) : super(ShipmentsLoading()) {
    on<LoadShipments>(_load);
    on<ShipmentsTypeChanged>(_onTypeChanged);
    on<ShipmentDeleted>(_onDelete);
  }

  Future<void> _load(LoadShipments event, Emitter<ShipmentsState> emit) async {
    try {
      emit(ShipmentsLoading());
      final shipments = await repository.fetchShipments();
      _allItems = shipments.map((s) => s.toShipmentUi()).toList();
      emit(
        ShipmentsLoaded(
          items: _allItems, 
          selectedType: ShipmentType.all, 
          hasActiveFilters: false
        )
      );
    } catch (e) {
      emit(ShipmentsError(e.toString()));
    }
  }

  void _onTypeChanged(ShipmentsTypeChanged event, Emitter<ShipmentsState> emit) {
    if (state is! ShipmentsLoaded) return;

    final filtered = event.type == ShipmentType.all
        ? _allItems
        : _allItems.where((e) => e.type == event.type).toList();

    emit(
      ShipmentsLoaded(
          items: filtered, 
          selectedType: event.type, 
          hasActiveFilters: (state as ShipmentsLoaded).hasActiveFilters,
        )
    );
  }

  void _onDelete(ShipmentDeleted event, Emitter<ShipmentsState> emit) async {
    if (state is! ShipmentsLoaded) return;
    final current = (state as ShipmentsLoaded);

    try {
      emit(ShipmentsLoading());
      await repository.deleteShipment(event.shipmentId);
      final index = current.items.indexWhere((c) => c.id == event.shipmentId);
      _allItems.removeAt(index);
      emit(
        current.copyWith(
          items: _allItems
        )
      );
    } catch (e) {
      emit(ShipmentsError(e.toString()));
    }
  }
}