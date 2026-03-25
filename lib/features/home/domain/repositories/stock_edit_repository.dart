abstract class StockEditRepository {
  Future<void> updateStocks({required Map<int, int> items});
}