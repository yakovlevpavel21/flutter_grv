part of "product_bloc.dart"; 

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoadProducts extends ProductEvent {}
class ChangeProductStock extends ProductEvent {
  final String productId;
  final int amount;
  final String type;


  ChangeProductStock(this.productId, this.amount, this.type);


  @override
  List<Object?> get props => [productId, amount, type];
}


class CreateProduct extends ProductEvent {
  final String name;
  final String sku;
  final String? category;
  final String? description;

  CreateProduct({
    required this.name,
    required this.sku,
    this.category,
    this.description,
  });

  @override
  List<Object?> get props => [name, sku, category, description];
}


class UpdateProduct extends ProductEvent {
  final String id;
  final String name;
  final String sku;
  final String? category;
  final String? description;

  UpdateProduct({
    required this.id,
    required this.name,
    required this.sku,
    this.category,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, sku, category, description];
}


class DeleteProduct extends ProductEvent {
  final String id;

  DeleteProduct(this.id);

  @override
  List<Object?> get props => [id];
}