part of "colors_bloc.dart"; 

abstract class ColorsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadColors extends ColorsEvent {}
class DeleteColor extends ColorsEvent {
  final int id;
  DeleteColor({required this.id});

  @override
  List<Object?> get props => [id];
}