part of "colors_bloc.dart";

abstract class ColorsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ColorsInitial extends ColorsState {}
class ColorsLoading extends ColorsState {}
class ColorsLoaded extends ColorsState {
  final List<ColorEntity> items;

  ColorsLoaded({
    required this.items,
  });

  @override
  List<Object?> get props => [items];
}
class ColorsError extends ColorsState {
  final String message;
  ColorsError(this.message);
  @override
  List<Object?> get props => [message];
}