import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/product/data/repos/semi_stock_repo.dart';
import 'package:grv/features/product/data/repos/variant_repo.dart';

part "semi_stock_event.dart"; 
part "semi_stock_state.dart"; 

class SemiStockBloc extends Bloc<SemiStockEvent, SemiStockState> {
  final SemiStockRepository repository;

  SemiStockBloc(this.repository) : super(SemiStockInitial()) {
    on<CreateSemiStock>(_createSemiStock);
    on<UpdateSemiStock>(_updateSemiStock);
    on<DeleteSemiStock>(_deleteSemiStock);
  }

  Future<void> _createSemiStock(CreateSemiStock event, Emitter<SemiStockState> emit) async {
    try {
      emit(SemiStockLoading());
      await repository.createSemiStock(event.quantity, event.colorId, event.productId);
      emit(SemiStockSuccess());
    } catch (e) {
      emit(SemiStockError(e.toString()));
    }
  }

  Future<void> _updateSemiStock(UpdateSemiStock event, Emitter<SemiStockState> emit) async {
    try {
      emit(SemiStockLoading());
      await repository.updateSemiStock(event.id, event.quantity, event.colorId);
      emit(SemiStockSuccess());
    } catch (e) {
      emit(SemiStockError(e.toString()));
    }
  }

  Future<void> _deleteSemiStock(DeleteSemiStock event, Emitter<SemiStockState> emit) async {
    try {
      emit(SemiStockLoading());
      await repository.deleteSemiStock(event.id);
      emit(SemiStockSuccess());
    } catch (e) {
      emit(SemiStockError(e.toString()));
    }
  }
}