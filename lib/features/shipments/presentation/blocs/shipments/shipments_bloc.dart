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
    on<ShipmentsFilterShopAdded>(_onFilterShopAdd);
    on<ShipmentsFilterShopRemoved>(_onFilterShopRemove);
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
          selectedShopIds: []
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

    emit((state as ShipmentsLoaded)
      .copyWith(
        items: filtered,
        selectedType: event.type,
      )
    );
  }

  void _onFilterShopAdd(ShipmentsFilterShopAdded event, Emitter<ShipmentsState> emit) {
    if (state is! ShipmentsLoaded) return;
    final current = state as ShipmentsLoaded;

    final shopIds = current.selectedShopIds;
    shopIds.add(event.shopId);
    final filtered = _allItems.where((i) => shopIds.contains(i.shop.id)).toList();

    emit(current.copyWith(
      items: filtered,
      selectedShopIds: shopIds,
    ));
  }

  void _onFilterShopRemove(ShipmentsFilterShopRemoved event, Emitter<ShipmentsState> emit) {
    if (state is! ShipmentsLoaded) return;
    final current = state as ShipmentsLoaded;

    final shopIds = current.selectedShopIds;
    shopIds.remove(event.shopId);
    final filtered = shopIds.isNotEmpty 
        ? _allItems.where((i) => shopIds.contains(i.shop.id)).toList() 
        : _allItems;

    emit(current.copyWith(
      items: filtered,
      selectedShopIds: shopIds,
    ));
  }
}