import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/home/data/repositories/stock_edit_repository_impl.dart';

part 'stock_edit_event.dart';
part 'stock_edit_state.dart';

class StockEditBloc extends Bloc<StockEditEvent, StockEditState> {
  final StockEditRepositoryImpl repository;

  StockEditBloc({required this.repository}) : super(StockEditState.initial()) {
    on<StockChanged>(_onChange);
    on<StockSubmitted>(_onSubmit);
  }

  Future<void> _onChange(StockChanged event, Emitter<StockEditState> emit) async {
    try {
      // Используем Map.from(), чтобы создать НОВЫЙ объект в памяти
      final newStocks = Map<int, int>.from(state.stocks);
      
      newStocks[event.stockId] = event.quantity;
      
      emit(state.copyWith(
        stocks: newStocks,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: StockEditStatus.error
      ));
    }
  }

  Future<void> _onSubmit(StockSubmitted event, Emitter<StockEditState> emit) async {
    try {
      await repository.updateStocks(items: state.stocks);
      
      emit(state.copyWith(
        status: StockEditStatus.success
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: StockEditStatus.error
      ));
    }
  }
}