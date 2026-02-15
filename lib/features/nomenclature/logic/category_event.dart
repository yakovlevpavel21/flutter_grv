part of "category_bloc.dart"; 

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateCategory extends CategoryEvent {
  final String name;

  CreateCategory({required this.name});

  @override
  List<Object?> get props => [name];
}

class UpdateCategory extends CategoryEvent {
  final int id;
  final String name;

  UpdateCategory({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class DeleteCategory extends CategoryEvent {
  final int id;

  DeleteCategory({required this.id});

  @override
  List<Object?> get props => [id];
}