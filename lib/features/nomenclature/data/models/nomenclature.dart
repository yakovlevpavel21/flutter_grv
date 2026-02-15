import 'package:grv/features/nomenclature/data/models/category_item.dart';

class NomenclatureUi {
  final Map<int, CategoryItemUi> categories;

  NomenclatureUi({
    required this.categories,
  });

  List<CategoryItemUi> get categoriesList => categories.values.toList();
}