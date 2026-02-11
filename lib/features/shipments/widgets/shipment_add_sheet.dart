import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/widgets/icon_by_type.dart';

class ShipmentAddSheet extends StatelessWidget {
  const ShipmentAddSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const IconByType(type: ShipmentType.shipment),
            title: const Text("Отгрузить"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/shipments/new', extra: ShipmentType.shipment),
          ),
          Divider(height: 1,),
          ListTile(
            leading: const IconByType(type: ShipmentType.comeback),
            title: const Text("Вернуть"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/shipments/new', extra: ShipmentType.comeback),
          ),
        ],
      ),
    );
  }
}