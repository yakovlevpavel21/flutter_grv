part of "color_bloc.dart"; 

abstract class ColorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ColorNameChanged extends ColorEvent {
  final String name;
  ColorNameChanged({required this.name});

  @override
  List<Object?> get props => [name];
}
class ColorChanged extends ColorEvent {
  final Color color;
  ColorChanged({required this.color});

  @override
  List<Object?> get props => [color];
}
class ColorSubmitted extends ColorEvent {}
class ColorDeleted extends ColorEvent {
  final int id;
  ColorDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}