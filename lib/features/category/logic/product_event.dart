part of "product_bloc.dart"; 

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateProduct extends ProductEvent {
  final String name;
  final int categoryId;

  CreateProduct({required this.name, required this.categoryId});

  @override
  List<Object?> get props => [name, categoryId];
}

class UpdateProduct extends ProductEvent {
  final int id;
  final String name;
  final int categoryId;

  UpdateProduct({required this.id, required this.name, required this.categoryId});

  @override
  List<Object?> get props => [id, name, categoryId];
}

class DeleteProduct extends ProductEvent {
  final int id;

  DeleteProduct({required this.id});

  @override
  List<Object?> get props => [id];
}