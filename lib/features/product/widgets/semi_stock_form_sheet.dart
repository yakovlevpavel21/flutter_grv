import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/colors/data/models/color_item.dart';
import 'package:grv/features/colors/logic/colors_bloc.dart';
import 'package:grv/features/product/data/models/semi_stock_item.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/product/data/repos/semi_stock_repo.dart';
import 'package:grv/features/product/logic/semi_stock_bloc.dart';
import 'package:grv/widgets/confirm_card.dart';
import 'package:grv/widgets/dialog_card.dart';

class SemiStockFormSheet extends StatefulWidget {
  final NomenclatureBloc nomenclatureBloc;
  final int productId;
  final List<int> usedColorIds;
  final SemiStockItemUi? semiStock;
  const SemiStockFormSheet({
    super.key, 
    required this.nomenclatureBloc,
    required this.productId, 
    required this.usedColorIds,
    this.semiStock
  });

  @override
  State<SemiStockFormSheet> createState() => _SemiStockFormSheetState();
}

class _SemiStockFormSheetState extends State<SemiStockFormSheet> {
  late final TextEditingController quantityController;
  int colorId = -1;

  @override
  void initState() {
    super.initState();
    context.read<ColorsBloc>().add(LoadColors());
    quantityController = TextEditingController(text: widget.semiStock?.quantity.toString());
    if (widget.semiStock != null) {
      colorId = widget.semiStock!.color.id;
    }
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16, right: 16, top: 16,
      ),
      child: BlocProvider(
        create: (_) => SemiStockBloc(SemiStockRepository()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.semiStock != null ? 'Редактирование' : 'Новый полуфабрикат'),
                if (widget.semiStock != null)
                  IconButton(
                    onPressed: () {
                      final oldContext = context;

                      showDialog(
                        context: context, 
                        builder: (context) => DialogCard(
                          type: DialogType.warning,
                          message: 'Ты уверен?\nВсе инвентари этого товара будут удалены!',
                          button: BlocProvider(
                            create: (_) => SemiStockBloc(SemiStockRepository()),
                            child: _DeleteButton(
                              semiStockId: widget.semiStock!.id, 
                              onSuccess: () {
                                Navigator.of(context).pop();
                                oldContext.pop();
                                widget.nomenclatureBloc.add(LoadNomenclature());
                              }
                            ),
                          ),
                        ),
                      );
                    }, 
                    icon: Icon(
                      Icons.delete_forever, 
                      color: Colors.red,
                      size: 20,
                    )
                  ),
              ],
            ),
            const SizedBox(height: 16),

            BlocBuilder<ColorsBloc, ColorsState>(
              builder: (context, state) {
                final isLoading = state is ColorsLoading;
                final items = state is ColorsLoaded ? state.items : <ColorItemUi>[];
                
                ColorItemUi? selectedColor;
                if (widget.semiStock != null && items.isNotEmpty) {
                  try {
                    selectedColor = items.firstWhere(
                      (element) => element.id == widget.semiStock!.color.id
                    );
                  } catch (_) {
                    selectedColor = null; 
                  }
                }
                final filterItems = items.where((i) => !widget.usedColorIds.contains(i.id) || i.id == selectedColor?.id);

                return DropdownButtonFormField<ColorItemUi>(
                  initialValue: selectedColor,
                  decoration: InputDecoration(
                    labelText: 'Цвет',
                    border: const OutlineInputBorder(),
                    suffixIcon: isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : null,
                  ),
                  items: filterItems
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(s.name),
                        ),
                      )
                      .toList(),
                  onChanged: isLoading
                      ? null
                      : (color) {
                          if (color != null) {
                            setState(() {
                              colorId = color.id;
                            });
                          }
                        },
                );
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(), 
                labelText: 'Количество полуфабрикатов'
              ),
            ),
            const SizedBox(height: 16),
            BlocConsumer<SemiStockBloc, SemiStockState>(
              listener: (context, state) {
                if (state is SemiStockSuccess) {
                  Navigator.pop(context);
                  widget.nomenclatureBloc.add(LoadNomenclature());
                }
                if (state is SemiStockError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message))
                  );
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is SemiStockLoading 
                      ? null 
                      : () {
                          final event = widget.semiStock == null
                            ? CreateSemiStock(
                                quantity: int.parse(quantityController.text),
                                colorId: colorId,
                                productId: widget.productId,
                              )
                            : UpdateSemiStock(
                                id: widget.semiStock!.id, 
                                quantity: int.parse(quantityController.text),
                                colorId: colorId,
                              );
                              
                          context.read<SemiStockBloc>().add(event);
                        },
                    child: state is SemiStockLoading 
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Сохранить'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final int semiStockId;
  final VoidCallback onSuccess;

  const _DeleteButton({required this.semiStockId, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SemiStockBloc, SemiStockState>(
      listener: (context, state) {
        if (state is SemiStockSuccess) onSuccess();
        if (state is SemiStockError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is SemiStockLoading) return const CircularProgressIndicator();
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => context.read<SemiStockBloc>().add(DeleteSemiStock(id: semiStockId)),
          child: const Text('Удалить', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}