abstract class VariantEditRepository {
  Future<void> createVariant({
    required String name, 
    required int partsConsumed, 
    required int productId
  });
  Future<void> updateVariant({
    required int id, 
    required String name, 
    required int partsConsumed
  });
  Future<void> deleteVariant({
    required int id
  });
}