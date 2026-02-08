

import 'package:flutter/material.dart';
import 'package:grv/features/shipments/data/models/shipment_item.dart';
import 'package:grv/features/shipments/widgets/shipment_card.dart';

class ShipmentsList extends StatelessWidget {
  final List<ShipmentItemUi> items;

  const ShipmentsList({required this.items});

  @override
  Widget build(BuildContext context) {
    final grouped = groupByMonth(items);

    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: grouped.entries.map((e) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MonthHeader(e.key),
            ...e.value.map(
              (item) => ShipmentCard(item: item),
            ),
          ],
        );
      }).toList(),
    );
  }
}

Map<String, List<ShipmentItemUi>> groupByMonth(
  List<ShipmentItemUi> items,
) {
  final map = <String, List<ShipmentItemUi>>{};

  for (final item in items) {
    final key =
        '${item.date.month}.${item.date.year}';
    map.putIfAbsent(key, () => []).add(item);
  }

  return map;
}

class _MonthHeader extends StatelessWidget {
  final String title;

  const _MonthHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }
}
