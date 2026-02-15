part of "semi_stock_bloc.dart";

abstract class SemiStockState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SemiStockInitial extends SemiStockState {}
class SemiStockLoading extends SemiStockState {}
class SemiStockSuccess extends SemiStockState {}
class SemiStockError extends SemiStockState {
  final String message;

  SemiStockError(this.message);

  @override
  List<Object?> get props => [message];
}