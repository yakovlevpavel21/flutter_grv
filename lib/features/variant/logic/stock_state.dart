part of "stock_bloc.dart";

abstract class StockState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StockInitial extends StockState {}
class StockLoading extends StockState {}
class StockSuccess extends StockState {}
class StockError extends StockState {
  final String message;

  StockError(this.message);

  @override
  List<Object?> get props => [message];
}