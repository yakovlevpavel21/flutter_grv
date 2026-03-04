enum StockState { raw, built, packed }

extension StringToStockState on String {
  StockState toStockState() {
    return StockState.values.firstWhere((e) =>
      e.name.toLowerCase() == toLowerCase());
  }
}