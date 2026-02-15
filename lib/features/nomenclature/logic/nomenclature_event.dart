part of "nomenclature_bloc.dart"; 

abstract class NomenclatureEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNomenclature extends NomenclatureEvent {}
class CategorySelected extends NomenclatureEvent {
  final int id;

  CategorySelected({required this.id});

  @override
  List<Object?> get props => [id];
}
class ProductSelected extends NomenclatureEvent {
  final int id;

  ProductSelected({required this.id});

  @override
  List<Object?> get props => [id];
}
class VariantSelected extends NomenclatureEvent {
  final int id;

  VariantSelected({required this.id});

  @override
  List<Object?> get props => [id];
}
class SearchNomenclature extends NomenclatureEvent {
  final String query;

  SearchNomenclature({required this.query});

  @override
  List<Object?> get props => [query];
}