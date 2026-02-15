part of "stock_bloc.dart"; 

abstract class StockEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateStock extends StockEvent {
  final int variantId;
  final int colorId;
  final int built;
  final int packed;

  CreateStock({
    required this.variantId, 
    required this.colorId, 
    required this.built,
    required this.packed
  });

  @override
  List<Object?> get props => [variantId, colorId, built, packed];
}

class UpdateStock extends StockEvent {
  final int id;
  final int built;
  final int packed;

  UpdateStock({required this.id, required this.built, required this.packed});

  @override
  List<Object?> get props => [id, built, packed];
}

class DeleteStock extends StockEvent {
  final int id;

  DeleteStock({required this.id});

  @override
  List<Object?> get props => [id];
}