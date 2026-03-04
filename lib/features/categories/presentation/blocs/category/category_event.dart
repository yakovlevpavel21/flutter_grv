part of "category_bloc.dart"; 

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NameChanged extends CategoryEvent {
  final String name;

  NameChanged({required this.name});

  @override
  List<Object?> get props => [name];
}
class CategorySubmitted extends CategoryEvent {}
class DeleteCategory extends CategoryEvent {
  final int id;

  DeleteCategory({required this.id});

  @override
  List<Object?> get props => [id];
}