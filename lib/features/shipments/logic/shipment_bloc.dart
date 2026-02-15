import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/data/models/shipment.dart';
import 'package:grv/data/models/shop.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/data/models/shipment_product.dart';
import 'package:grv/features/shipments/data/repos/shipments_repo.dart';
import 'package:grv/features/shops/data/models/shop_item.dart';

part "shipment_event.dart"; 
part "shipment_state.dart"; 

class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  final ShipmentsRepository repository = ShipmentsRepository();

  ShipmentBloc() : super(ShipmentInitial.initial()) {
    on<ShipmentTypeChanged>(_onTypeChanged);
    on<ShipmentDateChanged>(_onDateChanged);
    on<ShipmentShopChanged>(_onShopChanged);
    on<ShipmentProductsAdded>(_onAddProduct);
    on<ShipmentProductRemoved>(_onRemoveProduct);
    on<ShipmentProductQuantityChanged>(_onChangeQuantityProduct);
    on<ShipmentSubmitted>(_onSubmit);
  }

  void _onTypeChanged(ShipmentTypeChanged event, Emitter<ShipmentState> emit) {
    if (state is! ShipmentInitial) return;

    emit(
      (state as ShipmentInitial).copyWith(
        type: event.type, 
        items: [],
      )
    );
  }

  void _onDateChanged(ShipmentDateChanged event, Emitter<ShipmentState> emit) {
    if (state is! ShipmentInitial) return;

    emit(
      (state as ShipmentInitial).copyWith(
        dateTime: event.dateTime,
      )
    );
  }

  void _onShopChanged(ShipmentShopChanged event, Emitter<ShipmentState> emit) {
    if (state is! ShipmentInitial) return;

    final current = state as ShipmentInitial;
    emit(
      current.copyWith(
        shop: event.shop,
        items: current.type == ShipmentType.comeback ? [] : current.items,
      )
    );
  }

  void _onAddProduct(ShipmentProductsAdded event, Emitter<ShipmentState> emit) {
    if (state is! ShipmentInitial) return;
    
    emit(
      (state as ShipmentInitial).copyWith(
        items: [...event.items, ...(state as ShipmentInitial).items],
      )
    );
  }

  void _onRemoveProduct(ShipmentProductRemoved event, Emitter<ShipmentState> emit) {
    if (state is! ShipmentInitial) return;

    emit(
      (state as ShipmentInitial).copyWith(
        items: (state as ShipmentInitial).items.where((i) => i.id != event.item.id).toList(),
      )
    );
  }

  void _onChangeQuantityProduct(ShipmentProductQuantityChanged event, Emitter<ShipmentState> emit) {
    if (state is! ShipmentInitial) return;

    final updateItems = (state as ShipmentInitial).items.map((item) {
      if (item.id == event.item.id) {
        final safeQty = event.quantity.clamp(0, item.maxQuantity);
        return item.copyWith(quantity: safeQty);
      }
      return item;
    }).toList();
    emit(
      (state as ShipmentInitial).copyWith(
        items: updateItems,
      )
    );
  }

  void _onSubmit(ShipmentSubmitted event, Emitter<ShipmentState> emit) async {
    if (state is! ShipmentInitial) return;
    final current = state as ShipmentInitial;
    emit(ShipmentLoading());
    try {
      await repository.createShipment(
        createdAt: current.dateTime, 
        shopId: current.shop!.id, 
        type: current.type, 
        items: current.items, 
      );
      emit(ShipmentSuccess());
    } catch (e){
      emit(ShipmentError(e.toString()));
    }
  }
}