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
      final raw = product.stocks.values
          .firstWhere((s) => s.color.id == color.id && s.state == StockState.raw);

      // Для каждого варианта ищем значения этого цвета
      final variantCells = variants.map((variant) {
        final variantStocks = variant.stocks.values.where((s) => s.color.id == color.id);
        
        final built = variantStocks
            .firstWhere((s) => s.state == StockState.built);
            
        final packed = variantStocks
            .firstWhere((s) => s.state == StockState.packed);

        return HomeVariantCellUi(
          builtId: built.id, 
          builtCount: built.quantity, 
          packedId: packed.id,
          packedCount: packed.quantity,
        );
      }).toList();

      return HomeTableRowUi(
        stockRawId: raw.id,
        color: color,
        rawCount: raw.quantity,
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
