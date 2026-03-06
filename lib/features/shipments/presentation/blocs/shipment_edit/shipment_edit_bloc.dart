import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/data/models/shop.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/data/repositories/shipment_edit_repository_impl.dart';
import 'package:grv/features/shipments/domain/entities/stock_details_entity.dart';
import 'package:grv/features/shipments/domain/entities/stock_shipment_entity.dart';
import 'package:grv/features/shops/data/models/shop_item.dart';

part "shipment_edit_event.dart"; 
part "shipment_edit_state.dart"; 

class ShipmentEditBloc extends Bloc<ShipmentEditEvent, ShipmentEditInitial> {
  final ShipmentEditRepositoryImpl repository = ShipmentEditRepositoryImpl();

  ShipmentEditBloc() : super(ShipmentEditInitial.initial()) {
    on<ShipmentTypeChanged>(_onTypeChanged);
    on<ShipmentDateChanged>(_onDateChanged);
    on<ShipmentShopChanged>(_onShopChanged);
    on<ShipmentProductAdded>(_onAddProduct);
    on<ShipmentProductRemoved>(_onRemoveProduct);
    on<ShipmentProductQuantityChanged>(_onChangeQuantityProduct);
    on<ShipmentSubmitted>(_onSubmit);
    on<ShipmentDeleted>(_onDelete);
  }

  void _onTypeChanged(ShipmentTypeChanged event, Emitter<ShipmentEditInitial> emit) {
    emit(state.copyWith(
      type: event.type, 
      items: [],
    ));
  }

  void _onDateChanged(ShipmentDateChanged event, Emitter<ShipmentEditInitial> emit) {
    emit(state.copyWith(
      dateTime: event.dateTime,
    ));
  }

  void _onShopChanged(ShipmentShopChanged event, Emitter<ShipmentEditInitial> emit) {
    emit(state.copyWith(
      shop: event.shop,
      items: state.type == ShipmentType.comeback ? [] : state.items,
    ));
  }

  void _onAddProduct(ShipmentProductAdded event, Emitter<ShipmentEditInitial> emit) {
    final stockShipment = StockShipmentEntity(stock: event.item, quantity: event.item.quantity);
    emit(state.copyWith(
      items: [stockShipment, ...state.items],
    ));
  }

  void _onRemoveProduct(ShipmentProductRemoved event, Emitter<ShipmentEditInitial> emit) {
    emit(state.copyWith(
      items: state.items.where((i) => i.stock.id != event.itemId).toList(),
    ));
  }

  void _onChangeQuantityProduct(ShipmentProductQuantityChanged event, Emitter<ShipmentEditInitial> emit) {
    final updateItems = state.items.map((item) {
      if (item.stock.id == event.stockId) {
        final safeQty = event.quantity.clamp(0, item.stock.quantity);
        return item.copyWith(quantity: safeQty);
      }
      return item;
    }).toList();
    emit(state.copyWith(
      items: updateItems,
    ));
  }

  Future<void> _onSubmit(ShipmentSubmitted event, Emitter<ShipmentEditInitial> emit) async {
    try {
      emit(state.copyWith(
        status: ShipmentEditStatus.loading
      ));
      await repository.createShipment(
        createdAt: state.dateTime, 
        shopId: state.shop!.id, 
        type: state.type, 
        items: state.items, 
      );
      emit(state.copyWith(
        status: ShipmentEditStatus.success
      ));
    } catch (e){
      emit(state.copyWith(
        status: ShipmentEditStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> _onDelete(ShipmentDeleted event, Emitter<ShipmentEditInitial> emit) async {
    try {
      emit(state.copyWith(
        status: ShipmentEditStatus.loading
      ));
      await repository.deleteShipment(id: event.id);
      emit(state.copyWith(
        status: ShipmentEditStatus.success
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ShipmentEditStatus.error,
        errorMessage: e.toString()
      ));
    }
  }
}