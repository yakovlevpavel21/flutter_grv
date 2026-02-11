part of "home_bloc.dart";

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}


class HomeLoading extends HomeState {}
//class HomeLoaded extends HomeState {
//  final HomeUiModel data;
//
//  HomeLoaded(this.data);
//
//  @override
//  List<Object?> get props => [data];
//}
class HomeLoaded extends HomeState {
  final List<CategoryProducts> categories;

  HomeLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
  @override
  List<Object?> get props => [message];
}