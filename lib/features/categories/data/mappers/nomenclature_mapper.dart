import 'package:grv/data/models/nomenclature.dart';

extension NomenclatureMapperUi on Nomenclature {
  //NomenclatureEntity toUi(){
  //  return NomenclatureEntity(
  //    categories: { for (final cat in categories) cat.id: _toCategoryItem(cat) }
  //  );
  //}
}

//Color _rgbToColor(String rgb) {
//  return Color(int.parse(rgb, radix: 16) + 0xFF000000);
//}
//
//ColorItemUi _toColorItem(ColorModel color) {
//  return ColorItemUi(
//    id: color.id, 
//    name: color.name, 
//    color: _rgbToColor(color.rgb)
//  );
//}
//
//StockItemUi _toStockItem(Stock stock) {
//  return StockItemUi(
//    id: stock.id,
//    color: _toColorItem(stock.color), 
//    built: stock.built, 
//    packed: stock.packed
//  );
//}
//
//SemiStockItemUi _toSemiStockItem(SemiStock semiStock) {
//  return SemiStockItemUi(
//    id: semiStock.id,
//    color: _toColorItem(semiStock.color), 
//    quantity: semiStock.quantity
//  );
//}
//
//VariantItemUi _toVariantItem(VariantStocks variant) {
//  return VariantItemUi(
//    id: variant.id,
//    name: variant.name, 
//    ratio: variant.ratio,
//    stocks: { for (final st in variant.stocks) st.id: _toStockItem(st) },
//  );
//}

//ProductItemUi _toProductItem(ProductStocks product) {
//  return ProductItemUi(
//    id: product.id, 
//    name: product.name, 
//    variants: { for (final inv in product.variants) inv.id: _toVariantItem(inv) }, 
//    semiStocks: { for (final ss in product.semiStocks) ss.id: _toSemiStockItem(ss) }, 
//  );
//}

//CategoryEntity _toCategoryItem(CategoryProducts category) {
//  return CategoryEntity(
//    id: category.id, 
//    name: category.name, 
//    products: { for (final pr in category.products) pr.id: _toProductItem(pr) }, 
//  );
//}