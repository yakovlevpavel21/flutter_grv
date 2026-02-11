import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/data/models/shipment.dart';
import 'package:grv/data/models/shop.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/data/models/shipment_product.dart';
import 'package:grv/features/shipments/data/repos/shipments_repo.dart';
import 'package:grv/features/shops/data/models/shop_item.dart';

part "add_shipment_event.dart"; 
part "add_shipment_state.dart"; 

class AddShipmentBloc extends Bloc<AddShipmentEvent, AddShipmentState> {
  final ShipmentsRepository repository = ShipmentsRepository();

  AddShipmentBloc() : super(AddShipmentInitial.initial()) {
    on<ShipmentTypeChanged>(_onTypeChanged);
    on<ShipmentDateChanged>(_onDateChanged);
    on<ShipmentShopChanged>(_onShopChanged);
    on<ShipmentProductsAdded>(_onAddProduct);
    on<ShipmentProductRemoved>(_onRemoveProduct);
    on<ShipmentProductQuantityChanged>(_onChangeQuantityProduct);
    on<ShipmentSubmitted>(_onSubmit);
  }

  void _onTypeChanged(ShipmentTypeChanged event, Emitter<AddShipmentState> emit) {
    if (state is! AddShipmentInitial) return;

    emit(
      (state as AddShipmentInitial).copyWith(
        type: event.type, 
        items: [],
      )
    );
  }

  void _onDateChanged(ShipmentDateChanged event, Emitter<AddShipmentState> emit) {
    if (state is! AddShipmentInitial) return;

    emit(
      (state as AddShipmentInitial).copyWith(
        dateTime: event.dateTime,
      )
    );
  }

  void _onShopChanged(ShipmentShopChanged event, Emitter<AddShipmentState> emit) {
    if (state is! AddShipmentInitial) return;

    final current = state as AddShipmentInitial;
    emit(
      current.copyWith(
        shop: event.shop,
        items: current.type == ShipmentType.comeback ? [] : current.items,
      )
    );
  }

  void _onAddProduct(ShipmentProductsAdded event, Emitter<AddShipmentState> emit) {
    if (state is! AddShipmentInitial) return;
    
    emit(
      (state as AddShipmentInitial).copyWith(
        items: [...event.items, ...(state as AddShipmentInitial).items],
      )
    );
  }

  void _onRemoveProduct(ShipmentProductRemoved event, Emitter<AddShipmentState> emit) {
    if (state is! AddShipmentInitial) return;

    emit(
      (state as AddShipmentInitial).copyWith(
        items: (state as AddShipmentInitial).items.where((i) => i.id != event.item.id).toList(),
      )
    );
  }

  void _onChangeQuantityProduct(ShipmentProductQuantityChanged event, Emitter<AddShipmentState> emit) {
    if (state is! AddShipmentInitial) return;

    final updateItems = (state as AddShipmentInitial).items.map((item) {
      if (item.id == event.item.id) {
        final safeQty = event.quantity.clamp(0, item.maxQuantity);
        return item.copyWith(quantity: safeQty);
      }
      return item;
    }).toList();
    emit(
      (state as AddShipmentInitial).copyWith(
        items: updateItems,
      )
    );
  }

  void _onSubmit(ShipmentSubmitted event, Emitter<AddShipmentState> emit) async {
    if (state is! AddShipmentInitial) return;
    final current = state as AddShipmentInitial;
    emit(AddShipmentLoading());
    try {
      await repository.createShipment(
        createdAt: current.dateTime, 
        shopId: current.shop!.id, 
        type: current.type, 
        items: current.items, 
      );
      emit(AddShipmentSuccess());
    } catch (e){
      emit(AddShipmentError(e.toString()));
    }
  }
}