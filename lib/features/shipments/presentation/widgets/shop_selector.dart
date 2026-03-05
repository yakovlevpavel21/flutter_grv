import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/shipments/presentation/blocs/shipment_edit/shipment_edit_bloc.dart';
import 'package:grv/features/shops/data/models/shop_item.dart';
import 'package:grv/features/shops/logic/shops_bloc.dart';

class ShopSelector extends StatelessWidget {
  const ShopSelector({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShipmentEditBloc, ShipmentEditInitial>(
      builder: (context, stateShip) {
        return BlocBuilder<ShopsBloc, ShopsState>(
          builder: (context, state) {
            final isLoading = state is ShopsLoading;
            final items = state is ShopsLoaded ? state.items : <ShopItemUi>[];

            return DropdownButtonFormField<ShopItemUi>(
              initialValue: stateShip.shop,
              decoration: InputDecoration(
                labelText: 'Магазин',
                border: const OutlineInputBorder(),
                suffixIcon: isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : null,
              ),
              items: items
                  .map(
                    (s) => DropdownMenuItem(
                      value: s,
                      child: Text(s.title),
                    ),
                  )
                  .toList(),
              onChanged: isLoading
                  ? null
                  : (shop) {
                      if (shop != null) {
                        context
                            .read<ShipmentEditBloc>()
                            .add(ShipmentShopChanged(shop));
                      }
                    },
            );
          },
        );
      },
    );
  }
}