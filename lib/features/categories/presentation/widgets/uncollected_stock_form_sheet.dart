import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/domain/entities/stock_entity.dart';
import 'package:grv/features/categories/domain/enums/stock_state.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/data/repositories/stock_edit_repository_impl.dart';
import 'package:grv/features/categories/presentation/blocs/stock/stock_bloc.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';
import 'package:grv/features/materials/presentation/blocs/colors/colors_bloc.dart';
import 'package:grv/widgets/base_form_sheet.dart';

class UncollectedStockFormSheet extends StatefulWidget {
  final int productId;
  final CategoriesBloc categoriesBloc;
  final ColorsBloc colorsBloc;
  final StockEntity? stock;

  const UncollectedStockFormSheet({
    super.key,
    required this.productId,
    required this.categoriesBloc,
    required this.colorsBloc,
    this.stock,
  });

  @override
  State<UncollectedStockFormSheet> createState() => _UncollectedStockFormSheetState();
}

class _UncollectedStockFormSheetState extends State<UncollectedStockFormSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: BlocProvider(
        create: (_) => StockBloc(
          repository: StockEditRepositoryImpl(),
          productId: widget.productId,
          state: StockState.raw,
          stockEntity: widget.stock,
        ),
        child: BlocListener<StockBloc, StockInitial>(
          listenWhen: (p, c) => c.status == StockStatus.success,
          listener: (context, state) {
            Navigator.pop(context);
            widget.categoriesBloc.add(LoadCategories());
          },
          child: _StockUncollectedFormBody(colorsBloc: widget.colorsBloc),
        ),
      ),
    );
  }
}

class _StockUncollectedFormBody extends StatefulWidget {
  final ColorsBloc colorsBloc;
  const _StockUncollectedFormBody({required this.colorsBloc});

  @override
  State<_StockUncollectedFormBody> createState() => _StockUncollectedFormBodyState();
}

class _StockUncollectedFormBodyState extends State<_StockUncollectedFormBody> {
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    final quantity = context.read<StockBloc>().state.quantity;
    _quantityController = TextEditingController(text: quantity.toString());
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockBloc, StockInitial>(
      builder: (context, state) {
        return BaseFormSheet(
          title: state.isEditing ? 'Редактирование' : 'Добавление',
          isLoading: state.status == StockStatus.loading,
          canSubmit: state.canSubmit,
          onSave: () => context.read<StockBloc>().add(StockSubmitted()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ColorChoiceRow(
                colorsBloc: widget.colorsBloc,
                categoriesBloc: (context.findAncestorWidgetOfExactType<UncollectedStockFormSheet>())!.categoriesBloc,
                productId: (context.findAncestorWidgetOfExactType<UncollectedStockFormSheet>())!.productId,
                currentStockId: state.id,
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _quantityController,
                onChanged: (v) => context.read<StockBloc>().add(QuantityChanged(quantity: int.tryParse(v) ?? -1)),
                decoration: const InputDecoration(labelText: 'Количество', border: OutlineInputBorder()),
              ),
            ],
          ),
        );
      }
    );
  }
}


class _ColorChoiceRow extends StatelessWidget {
  final ColorsBloc colorsBloc;
  final CategoriesBloc categoriesBloc;
  final int productId;
  final int? currentStockId;

  const _ColorChoiceRow({
    required this.colorsBloc,
    required this.categoriesBloc,
    required this.productId,
    this.currentStockId,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColorId = context.read<StockBloc>().state.colorId;

    return BlocBuilder<ColorsBloc, ColorsState>(
      bloc: colorsBloc,
      builder: (context, colorsState) {
        return BlocBuilder<CategoriesBloc, CategoriesState>(
          bloc: categoriesBloc,
          builder: (context, categoriesState) {
            if (colorsState is ColorsLoaded && categoriesState is CategoriesLoaded) {
              final usedColorIds = <int>{};
              
              for (var category in categoriesState.categories.values) {
                for (var product in category.products.values) {
                  if (product.id == productId) {
                    for (var s in product.stocks.values) {
                      if (s.id != currentStockId && s.state == StockState.raw) {
                        usedColorIds.add(s.color.id);
                      }
                    }
                  }
                }
              }

              final filteredColors = colorsState.items.where((color) {
                return !usedColorIds.contains(color.id);
              }).toList();

              if (filteredColors.isEmpty) {
                return Text('Цвета для выбора отсутствуют', style: TextStyle(color: Colors.red),);
              }

              return SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredColors.length,
                  itemBuilder: (context, index) {
                    final color = filteredColors[index];
                    return _ColorChoiceItem(
                      color: color,
                      isSelected: selectedColorId == color.id,
                    );
                  },
                ),
              );
            }
            return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
          },
        );
      },
    );
  }
}

class _ColorChoiceItem extends StatelessWidget {
  final ColorEntity color;
  final bool isSelected;
  const _ColorChoiceItem({required this.color, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<StockBloc>().add(ColorIdChanged(colorId: color.id));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            Text(
              color.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}