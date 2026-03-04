part of "variant_bloc.dart";

enum VariantStatus { initial, loading, success, error }

class VariantInitial extends Equatable {
  final int? id;
  final String name;
  final int partsConsumed;
  final int productId;
  final bool isEditing;
  final VariantStatus status;
  final String? errorMessage;

  const VariantInitial({
    this.id,
    required this.name,
    required this.partsConsumed,
    required this.productId,
    required this.isEditing,
    required this.status,
    this.errorMessage,
  });

  bool get canSubmit =>
      name.isNotEmpty && partsConsumed >= 1;

  factory VariantInitial.initial({
    required VariantEntity? variantEntity,
    required int productId,
  }) {
    return VariantInitial(
      id: variantEntity?.id, 
      name: variantEntity?.name ?? '',
      partsConsumed: variantEntity?.partsConsumed ?? 1,
      productId: productId,
      isEditing: variantEntity != null,
      status: VariantStatus.initial,
    );
  }

  VariantInitial copyWith({
    int? id,
    String? name,
    int? partsConsumed,
    int? productId,
    bool? isEditing,
    VariantStatus? status,
    String? errorMessage,
  }) {
    return VariantInitial(
      id: id ?? this.id, 
      name: name ?? this.name,
      partsConsumed: partsConsumed ?? this.partsConsumed,
      productId: productId ?? this.productId, 
      isEditing: isEditing ?? this.isEditing,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    partsConsumed,
    productId,
    isEditing,
    status,
    errorMessage,
  ];
}