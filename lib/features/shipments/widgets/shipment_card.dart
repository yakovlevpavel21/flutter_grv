import 'package:flutter/material.dart';
import 'package:grv/features/shipments/data/models/shipment_item.dart';
import 'package:grv/features/shipments/widgets/icon_by_type.dart';
import 'package:grv/features/shipments/widgets/shipment_details_sheet.dart';
import 'package:intl/intl.dart';

class ShipmentCard extends StatelessWidget {
  final ShipmentItemUi item;
  final List<String> weekDays = [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье',
  ];

  ShipmentCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openDetails(context),
      child: Card(
        shape: RoundedRectangleBorder(
          //side: BorderSide(width: 0.2),
          borderRadius: BorderRadius.circular(3)
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 2,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              IconByType(type: item.type),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(item.date),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item.shopName,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                '${item.totalQuantity} шт.',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ShipmentDetailsSheet(item: item),
    );
  }
}