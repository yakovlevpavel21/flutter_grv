import 'package:grv/features/categories/domain/entities/category_entity.dart';
import 'package:grv/features/categories/domain/entities/product_entity.dart';
import 'package:grv/features/categories/domain/enums/stock_state.dart';
import 'package:grv/features/home/data/models/home_category.dart';
import 'package:grv/features/home/data/models/home_model.dart';
import 'package:grv/features/home/data/models/home_product.dart';
import 'package:grv/features/home/data/models/home_table_row.dart';
import 'package:grv/features/home/data/models/home_variant_cell.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';

class HomeUiMapper {
  HomeUiModel map(List<CategoryEntity> categories) {
    return HomeUiModel(
      categories.map((category) => HomeCategoryUi(
        name: category.name,
        products: category.products.values.map(_mapProduct).toList(),
      )).toList(),
    );
  }

  HomeProductUi _mapProduct(ProductEntity product) {
    final variants = product.variants.values.toList();
    
    // 1. Собираем все уникальные цвета, которые есть в этом продукте (в raw и во всех вариантах)
    final Map<int, ColorEntity> allColorsMap = {};
    
    for (var stock in product.stocks.values) {
      allColorsMap[stock.color.id] = stock.color;
    }
    for (var variant in variants) {
      for (var stock in variant.stocks.values) {
        allColorsMap[stock.color.id] = stock.color;
      }
    }
    
    final allColors = allColorsMap.values.toList();

    // 2. Для каждого цвета формируем строку
    final rows = allColors.map((color) {
      // Считаем Raw для этого цвета
      final rawCount = product.stocks.values
          .where((s) => s.color.id == color.id && s.state == StockState.raw)
          .fold(0, (sum, s) => sum + s.quantity);

      // Для каждого варианта ищем значения этого цвета
      final variantCells = variants.map((variant) {
        final variantStocks = variant.stocks.values.where((s) => s.color.id == color.id);
        
        final built = variantStocks
            .where((s) => s.state == StockState.built)
            .fold(0, (sum, s) => sum + s.quantity);
            
        final packed = variantStocks
            .where((s) => s.state == StockState.packed)
            .fold(0, (sum, s) => sum + s.quantity);

        return HomeVariantCellUi(builtCount: built, packedCount: packed);
      }).toList();

      return HomeTableRowUi(
        color: color,
        rawCount: rawCount,
        variantCells: variantCells,
      );
    }).toList();

    return HomeProductUi(
      name: product.name,
      variantNames: variants.map((v) => v.name).toList(),
      rows: rows,
    );
  }
}
