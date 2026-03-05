import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/presentation/blocs/shipment_edit/shipment_edit_bloc.dart';
import 'package:grv/features/shipments/presentation/widgets/products_sheet.dart';
import 'package:grv/features/shipments/presentation/widgets/selector_product_tile.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShipmentEditBloc, ShipmentEditInitial>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Товары',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: Icon(
                    state.items.isEmpty ? Icons.add : Icons.edit,
                    size: 21,
                  ),
                  onPressed: () => {
                    _openProductsPicker(
                      context: context, 
                      type: state.type, 
                      shopName: state.shop?.title ?? '', 
                      selectedStockIds: state.items.map((i) => i.stock.id).toList()
                    )
                  },
                )
              ],
            ),
            
            const SizedBox(height: 12),

            if (state.items.isEmpty)
              const Text('Необходимо выбрать хотя бы один товар'),

            ...state.items.map(
              (item) => SelectedProductTile(item: item),
            ),
          ],
        );
      },
    );
  }
}

void _openProductsPicker({
  required BuildContext context,
  required ShipmentType type,
  required String shopName,
  required List<int> selectedStockIds
}) {

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => ProductsSheet(
      context: context,
      type: type,
      shopName: shopName,
      selectedStockIds: selectedStockIds,
    ),
  );
}