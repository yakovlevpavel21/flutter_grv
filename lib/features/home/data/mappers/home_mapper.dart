import 'package:grv/data/models/category_products.dart';
import 'package:grv/data/models/color.dart';
import 'package:grv/features/home/data/models/home_category.dart';
import 'package:grv/features/home/data/models/home_model.dart';
import 'package:grv/features/home/data/models/home_product.dart';
import 'package:grv/features/home/data/models/home_table_row.dart';
import 'package:grv/features/home/data/models/home_variant_cell.dart';
import 'package:grv/data/models/product_stocks.dart';

class HomeUiMapper {
  HomeUiModel map(List<CategoryProducts> categories) {
    return HomeUiModel(
      categories.map(_mapCategory).toList(),
    );
  }

  HomeCategoryUi _mapCategory(CategoryProducts category) {
    return HomeCategoryUi(
      name: category.name,
      products: category.products.map(_mapProduct).toList(),
    );
  }

  HomeProductUi _mapProduct(ProductStocks product) {
    final variants =
        product.inventories.map((e) => e.variant).toList();

    final Map<int, _RowBuilder> rows = {};

    for (final semi in product.semiStocks) {
      rows[semi.color.id] = _RowBuilder(
        color: semi.color,
        semiStock: semi.quantity,
      );
    }

    for (final inv in product.inventories) {
      for (final fp in inv.stocks) {
        final row = rows.putIfAbsent(
          fp.color.id,
          () => _RowBuilder(color: fp.color),
        );

        row.variantMap[inv.variant] =
            HomeVariantCellUi(built: fp.built, packed: fp.packed);
      }
    }

    final rowUi = rows.values
        .map((r) => r.build(variants))
        .toList()
      ..sort((a, b) => a.color.id.compareTo(b.color.id));

    return HomeProductUi(
      name: product.name,
      variants: variants,
      rows: rowUi,
    );
  }
}


class _RowBuilder {
  final ColorModel color;
  int semiStock = 0;
  final Map<String, HomeVariantCellUi> variantMap = {};

  _RowBuilder({
    required this.color,
    this.semiStock = 0,
  });

  HomeTableRowUi build(List<String> variants) {
    return HomeTableRowUi(
      color: color,
      semiFinished: semiStock,
      cells: variants
          .map(
            (v) => variantMap[v] ??
                HomeVariantCellUi(built: 0, packed: 0),
          )
          .toList(),
    );
  }
}