part of "categories_bloc.dart"; 

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoriesEvent {
  LoadCategories({this.completer});

  final Completer<void>? completer;
}
class SearchProducts extends CategoriesEvent {
  final String query;

  SearchProducts({required this.query});

  @override
  List<Object?> get props => [query];
}