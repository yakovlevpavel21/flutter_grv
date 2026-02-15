part of "variant_bloc.dart"; 

abstract class VariantEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateVariant extends VariantEvent {
  final String variant;
  final int ratio;
  final int productId;

  CreateVariant({required this.variant, required this.ratio, required this.productId});

  @override
  List<Object?> get props => [variant, ratio, productId];
}

class UpdateVariant extends VariantEvent {
  final int id;
  final String variant;
  final int ratio;

  UpdateVariant({required this.id, required this.variant, required this.ratio});

  @override
  List<Object?> get props => [id, variant, ratio];
}

class DeleteVariant extends VariantEvent {
  final int id;

  DeleteVariant({required this.id});

  @override
  List<Object?> get props => [id];
}