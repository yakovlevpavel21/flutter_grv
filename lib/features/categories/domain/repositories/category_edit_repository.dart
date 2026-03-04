abstract class CategoryEditRepository {
  Future<void> createCategory({ required String name });
  Future<void> updateCategory({ required int id, required String name });
  Future<void> deleteCategory({ required int id });
}