abstract class ProductEditRepository {
    Future<void> createProduct({required String name, required int categoryId});
    Future<void> updateProduct({required int id, required String name, required int categoryId});
    Future<void> deleteProduct({required int id});
}