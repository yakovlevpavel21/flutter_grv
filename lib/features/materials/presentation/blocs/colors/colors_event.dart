part of "colors_bloc.dart"; 

abstract class ColorsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadColors extends ColorsEvent {
  LoadColors({this.completer});

  final Completer? completer;
}