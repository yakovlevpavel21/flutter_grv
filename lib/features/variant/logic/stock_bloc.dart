import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/variant/data/repos/stock_repo.dart';

part "stock_event.dart"; 
part "stock_state.dart"; 

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockRepository repository;

  StockBloc(this.repository) : super(StockInitial()) {
    on<CreateStock>(_createStock);
    on<UpdateStock>(_updateStock);
    on<DeleteStock>(_deleteStock);
  }

  Future<void> _createStock(CreateStock event, Emitter<StockState> emit) async {
    try {
      emit(StockLoading());
      await repository.createStock(event.variantId, event.colorId, event.built, event.packed);
      emit(StockSuccess());
    } catch (e) {
      emit(StockError(e.toString()));
    }
  }

  Future<void> _updateStock(UpdateStock event, Emitter<StockState> emit) async {
    try {
      emit(StockLoading());
      await repository.updateStock(event.id, event.built, event.packed);
      emit(StockSuccess());
    } catch (e) {
      emit(StockError(e.toString()));
    }
  }

  Future<void> _deleteStock(DeleteStock event, Emitter<StockState> emit) async {
    try {
      emit(StockLoading());
      await repository.deleteStock(event.id);
      emit(StockSuccess());
    } catch (e) {
      emit(StockError(e.toString()));
    }
  }
}