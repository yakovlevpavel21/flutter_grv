import 'dart:ffi';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/home/data/repositories/stock_edit_repository_impl.dart';
import 'package:grv/features/home/domain/entities/home_product_entity.dart';
import 'package:grv/features/home/domain/entities/home_table_row_entity.dart';
import 'package:grv/features/home/domain/entities/home_variant_cell_entity.dart';
import 'package:grv/features/home/presentation/blocs/stock_edit_bloc.dart';
import 'package:grv/features/home/presentation/widgets/color_cell.dart';
import 'package:grv/widgets/base_form_sheet.dart';

class StockEditSheet extends StatefulWidget {
  final HomeProductEntity productRowUi;
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
    return BlocProvider(
      create: (_) => StockEditBloc(
        repository: StockEditRepositoryImpl(),
      ),
      child: BlocListener<StockEditBloc, StockEditState>(
        listenWhen: (p, c) => c.status == StockEditStatus.success,
        listener: (context, state) {
          Navigator.pop(context);
          context.read<CategoriesBloc>().add(LoadCategories());
        },
        child: _StockEditFormBody(
          productRowUi: widget.productRowUi,
          tableRowIndex: widget.tableRowIndex,
        ),
      ),
    );
  }
}

class _StockEditFormBody extends StatefulWidget {
  final HomeProductEntity productRowUi;
  final int tableRowIndex;

  const _StockEditFormBody({
    required this.productRowUi, 
    required this.tableRowIndex
  });

  @override
  State<_StockEditFormBody> createState() => __StockEditFormBodyState();
}

class __StockEditFormBodyState extends State<_StockEditFormBody> {
  @override
  Widget build(BuildContext context) {
    // Используем BlocBuilder, чтобы UI реагировал на изменения в стейте
    return BlocBuilder<StockEditBloc, StockEditState>(
      builder: (context, state) {
        final tableRow = widget.productRowUi.rows[widget.tableRowIndex];

        return BaseFormSheet(
          title: widget.productRowUi.name,
          leading: ColorCell(colorEntity: tableRow.color, showTitle: false),
          onSave: () {
            context.read<StockEditBloc>().add(StockSubmitted());
          },
          isLoading: state.status == StockEditStatus.loading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Получаем текущее значение из стейта, если его там нет - из исходных данных
              _StockRow(
                stockId: tableRow.stockRawId,
                quantity: state.stocks[tableRow.stockRawId] ?? tableRow.rawCount, 
                title: 'Не собранные',
              ),
              ...tableRow.variantCells.mapIndexed((index, v) {
                return _VariantSection(
                  variantName: widget.productRowUi.variantNames[index],
                  variantCellUi: v,
                  // Передаем текущие значения из стейта
                  builtQty: state.stocks[v.stockBuiltId] ?? v.builtCount,
                  packedQty: state.stocks[v.stockPackedId] ?? v.packedCount,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class _VariantSection extends StatelessWidget {
  final String variantName;
  final HomeVariantCellEntity variantCellUi;
  final int builtQty;
  final int packedQty;

  const _VariantSection({
    required this.variantName,
    required this.variantCellUi,
    required this.builtQty,
    required this.packedQty,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Вариант: $variantName',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        _StockRow(
          stockId: variantCellUi.stockBuiltId,
          quantity: builtQty,
          title: 'Собранные',
        ),
        _StockRow(
          stockId: variantCellUi.stockPackedId,
          quantity: packedQty,
          title: 'Упакованные',
        ),
      ],
    );
  }
}

class _StockRow extends StatefulWidget {
  final int stockId;
  final int quantity;
  final String title;

  const _StockRow({
    required this.stockId,
    required this.quantity,
    required this.title,
  });

  @override
  State<_StockRow> createState() => _StockRowState();
}

class _StockRowState extends State<_StockRow> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.quantity.toString());
  }

  @override
  void didUpdateWidget(_StockRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Обновляем текст в контроллере, если значение изменилось извне (кнопками)
    if (oldWidget.quantity != widget.quantity) {
      _controller.text = widget.quantity.toString();
      // Ставим курсор в конец
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove, size: 20),
              onPressed: widget.quantity > 0
                  ? () {
                      context.read<StockEditBloc>().add(
                            StockChanged(
                                stockId: widget.stockId,
                                quantity: widget.quantity - 1),
                          );
                    }
                  : null,
            ),
            SizedBox(
              width: 50,
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  int qty = int.tryParse(value) ?? 0;
                  context.read<StockEditBloc>().add(
                        StockChanged(stockId: widget.stockId, quantity: qty),
                      );
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, size: 20),
              onPressed: () {
                context.read<StockEditBloc>().add(
                      StockChanged(
                          stockId: widget.stockId,
                          quantity: widget.quantity + 1),
                    );
              },
            ),
          ],
        ),
      ],
    );
  }
}