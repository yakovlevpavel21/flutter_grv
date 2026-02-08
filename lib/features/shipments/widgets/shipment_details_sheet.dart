

import 'package:flutter/material.dart';
import 'package:grv/features/shipments/data/models/shipment_item.dart';

class ShipmentDetailsSheet extends StatelessWidget {
  final ShipmentItemUi item;

  const ShipmentDetailsSheet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.shopName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...item.products.map(
            (p) => ListTile(
              title: Text(p.productName),
              subtitle: Text('${p.variant} • ${p.color}'),
              trailing: Text('${p.quantity}'),
            ),
          ),
        ],
      ),
    );
  }
}
