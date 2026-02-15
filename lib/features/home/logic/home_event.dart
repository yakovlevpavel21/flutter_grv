part of "home_bloc.dart"; 

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoadHome extends HomeEvent {}
class PackedCountChanged extends HomeEvent {
  final int stockId;
  final int value;

  PackedCountChanged(this.stockId, this.value);

  @override
  List<Object?> get props => [stockId, value];
}

class BuiltCountChanged extends HomeEvent {
  final int stockId;
  final int value;

  BuiltCountChanged(this.stockId, this.value);

  @override
  List<Object?> get props => [stockId, value];
}

class NotBuiltCountChanged extends HomeEvent {
  final int semiStockId;
  final int value;

  NotBuiltCountChanged(this.semiStockId, this.value);

  @override
  List<Object?> get props => [semiStockId, value];
}