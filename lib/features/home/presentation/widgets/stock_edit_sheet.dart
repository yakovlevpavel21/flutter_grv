import 'dart:ffi';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:grv/features/home/data/models/home_product.dart';
import 'package:grv/features/home/data/models/home_table_row.dart';
import 'package:grv/features/home/data/models/home_variant_cell.dart';
import 'package:grv/features/home/presentation/widgets/color_cell.dart';
import 'package:grv/widgets/base_form_sheet.dart';

class StockEditSheet extends StatefulWidget {
  final HomeProductUi productRowUi;
  final int tableRowIndex;

  const StockEditSheet({
    super.key, 
    required this.productRowUi, 
    required this.tableRowIndex
  });

  @override
  State<StockEditSheet> createState() => _StockEditSheetState();
}

class _StockEditSheetState extends State<StockEditSheet> {
  @override
  Widget build(BuildContext context) {
    final tableRow = widget.productRowUi.rows[widget.tableRowIndex];

    return BaseFormSheet(
      title: widget.productRowUi.name, 
      subtitle: ColorCell(colorEntity: tableRow.color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StockRow(quantity: 1, buttonName: 'Изготовить',),
          ...tableRow.variantCells.mapIndexed((index, v) => _VariantSection(
            variantName: widget.productRowUi.variantNames[index],
            variantCellUi: v,
          ))
        ],
      ),
    );
  }
}

class _VariantSection extends StatelessWidget {
  final String variantName;
  final HomeVariantCellUi variantCellUi;
  const _VariantSection({
    required this.variantName,
    required this.variantCellUi,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text('Вариант: $variantName'),
        ),
        _StockRow(quantity: 0, buttonName: 'Собрать'),
        SizedBox(height: 5,),
        _StockRow(quantity: 0, buttonName: 'Упаковать'),
      ],
    );
  }
}

class _StockRow extends StatelessWidget {
  final int quantity;
  final String buttonName;
  const _StockRow({required this.quantity, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 60,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder()
            ),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
          ),
        ),
        TextButton(
          onPressed: () {

          }, 
          child: SizedBox(
            width: 100, 
            child: Text(buttonName, textAlign: TextAlign.center,)
          )
        )
      ],
    );
  }
}