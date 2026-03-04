part of "stock_bloc.dart"; 

abstract class StockEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuantityChanged extends StockEvent {
  final int quantity;

  QuantityChanged({required this.quantity});

  @override
  List<Object?> get props => [quantity];
}
class ColorIdChanged extends StockEvent {
  final int colorId;

  ColorIdChanged({required this.colorId});

  @override
  List<Object?> get props => [colorId];
}
class StockSubmitted extends StockEvent {}
class StockDeleted extends StockEvent {
  final int id;

  StockDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}