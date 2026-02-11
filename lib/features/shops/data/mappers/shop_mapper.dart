import 'package:grv/data/models/shop.dart';
import 'package:grv/features/shops/data/models/shop_item.dart';

extension ShopToShopUi on Shop {
  ShopItemUi toShopUi() {
    return ShopItemUi(
      id: id,
      title: name,
    );
  }
}