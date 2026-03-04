part of "product_bloc.dart"; 

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NameChanged extends ProductEvent {
  final String name;

  NameChanged({required this.name});

  @override
  List<Object?> get props => [name];
}
class ProductSubmitted extends ProductEvent {}
class DeleteProduct extends ProductEvent {
  final int id;

  DeleteProduct({required this.id});

  @override
  List<Object?> get props => [id];
}