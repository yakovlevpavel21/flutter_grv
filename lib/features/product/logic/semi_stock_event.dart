part of "semi_stock_bloc.dart"; 

abstract class SemiStockEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateSemiStock extends SemiStockEvent {
  final int quantity;
  final int colorId;
  final int productId;

  CreateSemiStock({required this.quantity, required this.colorId, required this.productId});

  @override
  List<Object?> get props => [quantity, colorId, productId];
}

class UpdateSemiStock extends SemiStockEvent {
  final int id;
  final int quantity;
  final int colorId;

  UpdateSemiStock({required this.id, required this.quantity, required this.colorId});

  @override
  List<Object?> get props => [id, quantity, colorId];
}

class DeleteSemiStock extends SemiStockEvent {
  final int id;

  DeleteSemiStock({required this.id});

  @override
  List<Object?> get props => [id];
}