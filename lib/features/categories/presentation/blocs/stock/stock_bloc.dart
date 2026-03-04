import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/categories/domain/entities/stock_entity.dart';
import 'package:grv/features/categories/domain/enums/stock_state.dart';
import 'package:grv/features/categories/domain/repositories/stock_edit_repository.dart';

part "stock_event.dart"; 
part "stock_state.dart"; 

class StockBloc extends Bloc<StockEvent, StockInitial> {
  final StockEditRepository repository;

  StockBloc({
    required this.repository, 
    int? productId,
    int? variantId,
    required StockState state,
    StockEntity? stockEntity
  }) : super(StockInitial.initial(
    stockEntity: stockEntity,
    productId: productId,
    variantId: variantId,
    state: state
  )) {
    on<QuantityChanged>(_quantityChange);
    on<ColorIdChanged>(_colorIdChange);
    on<StockSubmitted>(_submit);
    on<StockDeleted>(_deleteStock);
  }

  void _quantityChange(QuantityChanged event, Emitter<StockInitial> emit) {
    try {
      emit(state.copyWith(
        quantity: event.quantity,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StockStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  void _colorIdChange(ColorIdChanged event, Emitter<StockInitial> emit) {
    try {
      emit(state.copyWith(
        colorId: event.colorId,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StockStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> _submit(StockSubmitted event, Emitter<StockInitial> emit) async {
    try {
      emit(state.copyWith(
        status: StockStatus.loading
      ));
      if (state.isEditing) {
        await repository.updateStock(
          id: state.id!,
          colorId: state.colorId, 
          quantity: state.quantity
        );
      } else {
        await repository.createStock(
          productId: state.productId!, 
          variantId: state.variantId, 
          colorId: state.colorId, 
          state: state.state.name, 
          quantity: state.quantity
        );
      }
      emit(state.copyWith(
        status: StockStatus.success
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StockStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> _deleteStock(StockDeleted event, Emitter<StockInitial> emit) async {
    try {
      emit(state.copyWith(
        status: StockStatus.loading
      ));
      await repository.deleteStock(id: event.id);
      emit(state.copyWith(
        status: StockStatus.success
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StockStatus.error,
        errorMessage: e.toString()
      ));
    }
  }
}