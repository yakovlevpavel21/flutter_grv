


import 'package:flutter/material.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';

class IconByType extends StatelessWidget {
  final ShipmentType type;

  const IconByType({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Icon(
      type == ShipmentType.shipment
          ? Icons.local_shipping //redo
          : Icons.undo,
      color: type == ShipmentType.shipment
          ? Colors.green
          : Colors.red,
    );
  }
}