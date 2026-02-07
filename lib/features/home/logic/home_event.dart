part of "home_bloc.dart"; 

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoadHome extends HomeEvent {}
class ChangeHomeStock extends HomeEvent {
  final String HomeId;
  final int amount;
  final String type;


  ChangeHomeStock(this.HomeId, this.amount, this.type);


  @override
  List<Object?> get props => [HomeId, amount, type];
}


class CreateHome extends HomeEvent {
  final String name;
  final String sku;
  final String? category;
  final String? description;

  CreateHome({
    required this.name,
    required this.sku,
    this.category,
    this.description,
  });

  @override
  List<Object?> get props => [name, sku, category, description];
}


class UpdateHome extends HomeEvent {
  final String id;
  final String name;
  final String sku;
  final String? category;
  final String? description;

  UpdateHome({
    required this.id,
    required this.name,
    required this.sku,
    this.category,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, sku, category, description];
}


class DeleteHome extends HomeEvent {
  final String id;

  DeleteHome(this.id);

  @override
  List<Object?> get props => [id];
}