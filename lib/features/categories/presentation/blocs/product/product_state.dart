part of "product_bloc.dart";

enum ProductStatus { initial, loading, success, error }

class ProductInitial extends Equatable {
  final int? id;
  final String name;
  final int categoryId;
  final bool isEditing;
  final ProductStatus status;
  final String? errorMessage;

  const ProductInitial({
    this.id,
    required this.name,
    required this.categoryId,
    required this.isEditing,
    required this.status,
    this.errorMessage,
  });

  bool get canSubmit =>
      name.isNotEmpty;

  factory ProductInitial.initial({
    required ProductEntity? productEntity,
    required int categoryId,
  }) {
    return ProductInitial(
      id: productEntity?.id, 
      name: productEntity?.name ?? '',
      categoryId: categoryId,
      isEditing: productEntity != null,
      status: ProductStatus.initial,
    );
  }

  ProductInitial copyWith({
    int? id,
    String? name,
    int? categoryId,
    bool? isEditing,
    ProductStatus? status,
    String? errorMessage,
  }) {
    return ProductInitial(
      id: id ?? this.id, 
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      isEditing: isEditing ?? this.isEditing,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    categoryId,
    isEditing,
    status,
    errorMessage,
  ];
}
