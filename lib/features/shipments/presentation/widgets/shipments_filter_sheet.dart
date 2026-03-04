import 'package:flutter/material.dart';

class ShipmentsFiltersSheet extends StatelessWidget {
  const ShipmentsFiltersSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Фильтры',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          ListTile(
            title: const Text('Магазин'),
            subtitle: const Text('Все'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // открыть выбор магазина
            },
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // context.read<ShipmentsBloc>().add(FiltersApplied(...))
              },
              child: const Text('Применить'),
            ),
          ),
        ],
      ),
    );
  }
}