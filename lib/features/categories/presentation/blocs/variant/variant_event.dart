part of "variant_bloc.dart"; 

abstract class VariantEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class NameChanged extends VariantEvent {
  final String name;

  NameChanged({required this.name});

  @override
  List<Object?> get props => [name];
}
class PartsConsumedChanged extends VariantEvent {
  final int partsConsumed;

  PartsConsumedChanged({required this.partsConsumed});

  @override
  List<Object?> get props => [partsConsumed];
}
class VariantSubmitted extends VariantEvent {}
class VariantDeleted extends VariantEvent {
  final int id;

  VariantDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}