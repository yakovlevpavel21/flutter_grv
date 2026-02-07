import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/products/logic/product_bloc.dart';

enum HistoryFilter { all, send, refund }

class ShipmentsScreen extends StatefulWidget {
  const ShipmentsScreen({super.key});

  @override
  State<ShipmentsScreen> createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<ShipmentsScreen> {
  HistoryFilter _filter = HistoryFilter.all;

  final List<HistoryItem> _items = [
    HistoryItem(
      type: HistoryType.send,
      title: 'Отправка №125',
      store: 'Магазин на Ленина',
      amount: -1500,
      date: DateTime(2026, 1, 15),
      products: [
        ProductItem('Футболка', 3),
        ProductItem('Кепка', 1),
      ],
    ),
    HistoryItem(
      type: HistoryType.refund,
      title: 'Возврат №124',
      store: 'ТРЦ Европа',
      amount: 500,
      date: DateTime(2026, 1, 10),
      products: [
        ProductItem('Джинсы', 1),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = _items.where((item) {
      if (_filter == HistoryFilter.all) return true;
      if (_filter == HistoryFilter.send) {
        return item.type == HistoryType.send;
      }
      return item.type == HistoryType.refund;
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        title: Text("История"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: _buildGroupedList(filteredItems),
              ),
            ),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _filterChip('Все', HistoryFilter.all),
            _filterChip('Отправки', HistoryFilter.send),
            _filterChip('Возвраты', HistoryFilter.refund),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String title, HistoryFilter value) {
    final isSelected = _filter == value;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        showCheckmark: false,
        label: Text(title),
        selected: isSelected,
        onSelected: (_) => setState(() => _filter = value),
      ),
    );
  }

  /// ---------- ГРУППИРОВКА ПО МЕСЯЦАМ ----------
  List<Widget> _buildGroupedList(List<HistoryItem> items) {
    final Map<String, List<HistoryItem>> grouped = {};

    for (final item in items) {
      final key = '${item.date.month}.${item.date.year}';
      grouped.putIfAbsent(key, () => []).add(item);
    }

    return grouped.entries.map((entry) {
      final monthTitle = _monthName(entry.value.first.date);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            monthTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...entry.value.map(_historyTile),
        ],
      );
    }).toList();
  }

  Widget _historyTile(HistoryItem item) {
    final isSend = item.type == HistoryType.send;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: () => _showDetails(item),
        leading: CircleAvatar(
          backgroundColor: isSend ? Colors.red.shade100 : Colors.green.shade100,
          child: Icon(
            isSend ? Icons.arrow_upward : Icons.arrow_downward,
            color: isSend ? Colors.red : Colors.green,
          ),
        ),
        title: Text(item.title),
        subtitle: Text('${item.store} • ${_formatDate(item.date)}'),
        trailing: Text(
          '${item.amount > 0 ? '+' : ''}${item.amount} ₽',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSend ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }

  void _showDetails(HistoryItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.type == HistoryType.send ? 'Отправка' : 'Возврат',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Магазин: ${item.store}'),
              Text('Дата: ${_formatDate(item.date)}'),

              const SizedBox(height: 16),
              const Text(
                'Товары',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),
              ...item.products.map(
                (p) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(p.name),
                      Text('×${p.quantity}'),
                    ],
                  ),
                ),
              ),

              const Divider(height: 32),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Итого: ${item.amount} ₽',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  /// ---------- КНОПКА ДОБАВЛЕНИЯ ----------
  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text(
            'Добавить',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: _showAddBottomSheet,
        ),
      ),
    );
  }

  void _showAddBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.arrow_upward),
            title: const Text('Добавить отправку'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.arrow_downward),
            title: const Text('Добавить возврат'),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// ---------- HELPERS ----------
  String _monthName(DateTime date) {
    const months = [
      'Январь',
      'Февраль',
      'Март',
      'Апрель',
      'Май',
      'Июнь',
      'Июль',
      'Август',
      'Сентябрь',
      'Октябрь',
      'Ноябрь',
      'Декабрь',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}

/// ---------- MODELS ----------
enum HistoryType { send, refund }

class HistoryItem {
  final HistoryType type;
  final String title;
  final String store;
  final int amount;
  final DateTime date;
  final List<ProductItem> products;

  HistoryItem({
    required this.type,
    required this.title,
    required this.store,
    required this.amount,
    required this.date,
    required this.products,
  });
}

class ProductItem {
  final String name;
  final int quantity;

  ProductItem(this.name, this.quantity);
}