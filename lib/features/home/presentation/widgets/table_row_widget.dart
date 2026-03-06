import 'package:flutter/material.dart';
import 'package:grv/features/home/data/models/home_table_row.dart';
import 'package:grv/features/home/data/models/home_variant_cell.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';

class TableRowWidget extends StatelessWidget {
  final HomeTableRowUi row;
  const TableRowWidget({super.key, required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Row(
        children: [
          // Колонка цвета
          Expanded(flex: 1, child: _ColorCell(row.color)), 
          // Колонка Raw (Не собранные)
          Expanded(flex: 1, child: _BigCell(row.rawCount)),
          // Колонки вариантов
          ...row.variantCells.map(
            (cell) => Expanded(flex: 1, child: _StageCell(cell: cell)),
          ),
        ],
      ),
    );
  }
}

class _ColorCell extends StatelessWidget {
  final ColorEntity color;

  const _ColorCell(this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color.color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black, width: 0.3),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            color.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _BigCell extends StatelessWidget {
  final int value;

  const _BigCell(this.value);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: value == 0 
        ? Text(
          '—',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        )
        : Text(
          '$value',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
    );
  }
}

class _StageCell extends StatelessWidget {
  final HomeVariantCellUi cell;
  const _StageCell({required this.cell});

  @override
  Widget build(BuildContext context) {
    if (cell.isEmpty) {
      return const Center(child: Text('—', style: TextStyle(fontSize: 12, color: Colors.grey)));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${cell.packedCount}', // Крупно - упакованные
          style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            color: cell.packedCount == 0 ? Colors.grey : Colors.black,
          ),
        ),
        if (cell.builtCount > 0)
          Text(
            ' (${cell.builtCount})', // Мелко - собранные, но не упакованные
            style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
          ),
      ],
    );
  }
}