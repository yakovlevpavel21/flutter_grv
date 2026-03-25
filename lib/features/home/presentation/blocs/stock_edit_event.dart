part of 'stock_edit_bloc.dart';

abstract class StockEditEvent {}

class StockChanged extends StockEditEvent {
  final int stockId;
  final int quantity;

  StockChanged({required this.stockId, required this.quantity});
}
class StockSubmitted extends StockEditEvent {}