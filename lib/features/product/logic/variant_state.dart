part of "variant_bloc.dart";

abstract class VariantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VariantInitial extends VariantState {}
class VariantLoading extends VariantState {}
class VariantSuccess extends VariantState {}
class VariantError extends VariantState {
  final String message;

  VariantError(this.message);

  @override
  List<Object?> get props => [message];
}