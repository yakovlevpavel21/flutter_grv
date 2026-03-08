import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:grv/features/home/data/models/home_product.dart';
import 'package:grv/features/home/presentation/widgets/stock_edit_sheet.dart';
import 'package:grv/features/home/presentation/widgets/table_header.dart';
import 'package:grv/features/home/presentation/widgets/table_row_widget.dart';

class ProductSection extends StatelessWidget {
  final HomeProductUi ui;
  const ProductSection({super.key, required this.ui});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(ui.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              TableHeader(variants: ui.variantNames), // Передаем список строк
              const Divider(height: 1),
              ...ui.rows.mapIndexed((index, r) => TableRowWidget(
                row: r,
                onTap: () {
                  showModalBottomSheet(
                    context: context, 
                    isScrollControlled: true,
                    builder: (_) => StockEditSheet(
                      productRowUi: ui, 
                      tableRowIndex: index
                    )
                  );
                },
              )),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}