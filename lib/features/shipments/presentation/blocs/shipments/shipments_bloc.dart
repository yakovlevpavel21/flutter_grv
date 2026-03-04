import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/data/repositories/shipments_repository_impl.dart';
import 'package:grv/features/shipments/domain/entities/shipment_entity.dart';

part "shipments_event.dart"; 
part "shipments_state.dart"; 

class ShipmentsBloc extends Bloc<ShipmentsEvent, ShipmentsState> {
  final ShipmentsRepositoryImpl repository;
  List<ShipmentEntity> _allItems = [];

  ShipmentsBloc(this.repository) : super(ShipmentsLoading()) {
    on<LoadShipments>(_load);
    on<ShipmentsTypeChanged>(_onTypeChanged);
  }

  Future<void> _load(LoadShipments event, Emitter<ShipmentsState> emit) async {
    try {
      emit(ShipmentsLoading());
      final shipments = await repository.getShipments();
      
      _allItems = shipments;
      emit(
        ShipmentsLoaded(
          items: _allItems, 
          selectedType: ShipmentType.all, 
          hasActiveFilters: false
        )
      );
    } catch (e) {
      emit(ShipmentsError(e.toString()));
    } finally {
      event.completer?.complete();
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
}