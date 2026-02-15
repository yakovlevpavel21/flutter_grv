part of "nomenclature_bloc.dart";

abstract class NomenclatureState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NomenclatureLoading extends NomenclatureState {}
class NomenclatureLoaded extends NomenclatureState {
  final NomenclatureUi nomenclature;
  final int? selectedCategoryId;
  final int? selectedProductId;
  final int? selectedVariantId;

  NomenclatureLoaded({
    required this.nomenclature,
    this.selectedCategoryId,
    this.selectedProductId,
    this.selectedVariantId,
  });

  NomenclatureLoaded copyWith({
    NomenclatureUi? nomenclature,
    int? selectedCategoryId,
    int? selectedProductId,
    int? selectedVariantId,
  }) {
    return NomenclatureLoaded(
      nomenclature: nomenclature ?? this.nomenclature,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedProductId: selectedProductId ?? this.selectedProductId,
      selectedVariantId: selectedVariantId ?? this.selectedVariantId,
    );
  }

  @override
  List<Object?> get props => [nomenclature, selectedCategoryId, selectedProductId, selectedVariantId];
}
class NomenclatureError extends NomenclatureState {
  final String message;

  NomenclatureError(this.message);

  @override
  List<Object?> get props => [message];
}