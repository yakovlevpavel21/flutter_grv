part of 'stock_edit_bloc.dart';

enum StockEditStatus { initial, loading, success, error }

class StockEditState extends Equatable {
  final Map<int, int> stocks;
  final StockEditStatus status;
  final String? errorMessage;
  
  const StockEditState({
    required this.stocks,
    required this.status,
    this.errorMessage,
  });

  bool get canSubmit =>
      stocks.entries.any((el) => el.value >= 0);

  StockEditState copyWith({
    Map<int, int>? stocks,
    StockEditStatus? status,
    String? errorMessage,
  }) {
    return StockEditState(
      stocks: stocks ?? this.stocks,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory StockEditState.initial() {
    return StockEditState(
      stocks: const {},
      status: StockEditStatus.initial,
    );
  }

  @override
  List<Object?> get props => [
    stocks,
    status,
    errorMessage
  ];
}