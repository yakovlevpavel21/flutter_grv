part of "categories_bloc.dart"; 

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoriesEvent {}
class SearchProducts extends CategoriesEvent {
  final String query;

  SearchProducts({required this.query});

  @override
  List<Object?> get props => [query];
}