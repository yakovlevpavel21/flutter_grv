part of "stock_bloc.dart";

enum StockStatus { initial, loading, success, error }

class StockInitial extends Equatable {
  final int? id;
  final int? productId;
  final int? variantId;
  final int colorId;
  final StockState state;
  final int quantity;
  final bool isEditing;
  final StockStatus status;
  final String? errorMessage;

  const StockInitial({
    this.id, 
    this.productId, 
    this.variantId, 
    required this.colorId, 
    required this.state, 
    required this.quantity, 
    required this.isEditing,
    required this.status,
    this.errorMessage,
  });

  bool get canSubmit =>
      quantity >= 0 &&
      ( state != StockState.raw && isEditing && variantId == null || state == StockState.raw && colorId != -1);

  factory StockInitial.initial({
    StockEntity? stockEntity,
    int? productId,
    int? variantId,
    required StockState state,
  }) {
    return StockInitial(
      id: stockEntity?.id, 
      productId: productId,
      variantId: variantId,
      colorId: stockEntity?.color.id ?? -1, 
      state: state,
      quantity: stockEntity?.quantity ?? 0,
      isEditing: stockEntity != null,
      status: StockStatus.initial,
    );
  }

  StockInitial copyWith({
    int? id,
    int? productId,
    int? variantId,
    int? colorId,
    StockState? state,
    int? quantity,
    bool? isEditing,
    StockStatus? status,
    String? errorMessage,
  }) {
    return StockInitial(
      id: id ?? this.id, 
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      colorId: colorId ?? this.colorId, 
      state: state ?? this.state,
      quantity: quantity ?? this.quantity,
      isEditing: isEditing ?? this.isEditing,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    productId,
    variantId,
    colorId,
    state,
    quantity, 
    isEditing,
    status,
    errorMessage,
  ];
}