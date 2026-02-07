part of "product_bloc.dart";

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}


class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<Product> products;


  ProductLoaded(this.products);


  @override
  List<Object?> get props => [products];
}
class ProductError extends ProductState {}