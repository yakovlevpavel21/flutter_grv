part of "categories_bloc.dart";

abstract class CategoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesLoading extends CategoriesState {}
class CategoriesLoaded extends CategoriesState {
  final Map<int, CategoryEntity> categories;

  CategoriesLoaded({
    required this.categories,
  });

  CategoriesLoaded copyWith({
    Map<int, CategoryEntity>? categories,
  }) {
    return CategoriesLoaded(
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [categories,];
}
class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError(this.message);

  @override
  List<Object?> get props => [message];
}