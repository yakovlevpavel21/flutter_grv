import 'package:flutter/material.dart';
import 'package:grv/features/shipments/data/models/shipment_item.dart';
import 'package:grv/features/shipments/widgets/shipment_card.dart';
import 'package:intl/intl.dart';

final months = [
  ['Январь', 'января'],
  ['Февраль', 'февраля'],
  ['Март', 'марта'],
  ['Апрель', 'апреля'],
  ['Май', 'мая'],
  ['Июнь', 'июня'],
  ['Июль', 'июля'],
  ['Август', 'августа'],
  ['Сентябрь', 'сентября'],
  ['Октябрь', 'октября'],
  ['Ноябрь', 'ноября'],
  ['Декабрь', 'декабря'],
];

final weekDays = [
  'Понедельник',
  'Вторник',
  'Среда',
  'Четверг',
  'Пятница',
  'Суббота',
  'Воскресенье',
];

class ShipmentsList extends StatelessWidget {
  final List<ShipmentItemUi> items;

  const ShipmentsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final grouped = groupByMonth(items);

    return ListView(
      padding: const EdgeInsets.only(bottom: 10),
      children: grouped.entries.map((e) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MonthHeader(e.key),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: e.value.entries.map((d) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DayHeader(d.key),

                    ...d.value.map(
                      (item) => ShipmentCard(item: item),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        );
      }).toList(),
    );
  }
}

Map<DateTime, Map<DateTime, List<ShipmentItemUi>>> groupByMonth(
  List<ShipmentItemUi> items,
) {
  final result = <DateTime, Map<DateTime, List<ShipmentItemUi>>>{};

  final sorted = [...items]
    ..sort((a, b) => b.date.compareTo(a.date));

  for(final item in sorted) {
    //final monthKey = '${months[item.date.month - 1]} ${item.date.year}';
    //final dayKey = '${weekDays[item.date.weekday - 1]}, ${DateFormat("dd").format(item.date)}';
    final monthKey = DateTime(item.date.year, item.date.month);
    final dayKey = DateTime(item.date.year, item.date.month, item.date.day);

    final monthMap = result.putIfAbsent(monthKey, () => {});
    final dayList = monthMap.putIfAbsent(dayKey, () => []);
    dayList.add(item);
  }

  return result;
}

class _MonthHeader extends StatelessWidget {
  final DateTime date;

  const _MonthHeader(this.date);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
      child: Text(
        '${months[date.month - 1][0]} ${date.year}',
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}


class _DayHeader extends StatelessWidget {
  final DateTime date;

  const _DayHeader(this.date);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
      child: Text(
        '${weekDays[date.weekday - 1]}, ${DateFormat("dd").format(date)} ${months[date.month - 1][1]}',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
