import 'package:flutter/material.dart';
import 'package:grv/features/home/domain/entities/home_table_row_entity.dart';
import 'package:grv/features/home/domain/entities/home_variant_cell_entity.dart';
import 'package:grv/features/home/presentation/widgets/color_cell.dart';

class TableRowWidget extends StatelessWidget {
  final HomeTableRowEntity row;
  final VoidCallback onTap;
  const TableRowWidget({super.key, required this.row, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            // Колонка цвета
            Expanded(flex: 1, child: ColorCell(colorEntity: row.color)), 
            // Колонка Raw (Не собранные)
            Expanded(flex: 1, child: _BigCell(row.rawCount)),
            // Колонки вариантов
            ...row.variantCells.map(
              (cell) => Expanded(flex: 1, child: _StageCell(cell: cell)),
            ),
          ],
        ),
      ),
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
  final HomeVariantCellEntity cell;
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