import 'package:flutter/material.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';

class ShipmentsTopBar extends StatelessWidget {
  final ShipmentType selected;
  final bool hasFilters;
  final VoidCallback onFiltersTap;
  final ValueChanged<ShipmentType> onTypeChanged;

  const ShipmentsTopBar({
    super.key, 
    required this.selected,
    required this.hasFilters,
    required this.onFiltersTap,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.filter_list,
                color: hasFilters ? Colors.blue : Colors.grey,
              ),
              onPressed: onFiltersTap,
            ),
            const SizedBox(width: 8),
            _Tab(
              title: 'Все',
              active: selected == ShipmentType.all,
              onTap: () => onTypeChanged(ShipmentType.all),
            ),
            const SizedBox(width: 8),
            _Tab(
              title: 'Отгрузки',
              active: selected == ShipmentType.shipment,
              onTap: () => onTypeChanged(ShipmentType.shipment),
            ),
            const SizedBox(width: 8),
            _Tab(
              title: 'Возвраты',
              active: selected == ShipmentType.comeback,
              onTap: () => onTypeChanged(ShipmentType.comeback),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String title;
  final bool active;
  final VoidCallback onTap;

  const _Tab({
    required this.title,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Colors.black : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}