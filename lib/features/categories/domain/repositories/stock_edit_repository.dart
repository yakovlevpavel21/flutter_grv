abstract class StockEditRepository {
  Future<void> createStock({
    required int productId, 
    int? variantId, 
    required int colorId, 
    required String state, 
    required int quantity
  });
  Future<void> updateStock({
    required int id, 
    required int colorId, 
    required int quantity
  });
  Future<void> deleteStock({required int id});
}