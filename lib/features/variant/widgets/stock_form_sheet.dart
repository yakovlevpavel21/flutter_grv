import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grv/features/colors/data/models/color_item.dart';
import 'package:grv/features/variant/data/models/stock_item.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/variant/data/repos/stock_repo.dart';
import 'package:grv/features/variant/logic/stock_bloc.dart';

class StockFormSheet extends StatefulWidget {
  final NomenclatureBloc nomenclatureBloc;
  final int variantId;
  final StockItemUi? stock;

  const StockFormSheet({
    super.key,
    required this.nomenclatureBloc,
    required this.variantId,
    this.stock,
  });

  @override
  State<StockFormSheet> createState() => _StockFormSheetState();
}

class _StockFormSheetState extends State<StockFormSheet> {
  late final TextEditingController builtController;
  late final TextEditingController packedController;
  
  // Храним выбранный цвет здесь, чтобы кнопка "Сохранить" имела к нему доступ
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    builtController = TextEditingController(text: widget.stock?.built.toString() ?? '0');
    packedController = TextEditingController(text: widget.stock?.packed.toString() ?? '0');
    selectedColor = widget.stock?.color.color ?? Colors.blue;
  }

  @override
  void dispose() {
    builtController.dispose();
    packedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Учет клавиатуры
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16, right: 16, top: 16,
      ),
      child: BlocProvider(
        create: (_) => StockBloc(StockRepository()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.stock != null ? 'Редактирование' : 'Новая продукция',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Селектор цвета
            _ColorPickerTile(
              currentColor: selectedColor,
              onColorChanged: (color) {
                setState(() => selectedColor = color);
              },
            ),

            _StockParamTile(textController: builtController, title: 'Количество собранных'),
            _StockParamTile(textController: packedController, title: 'Количество упакованных'),

            const SizedBox(height: 24),

            BlocConsumer<StockBloc, StockState>(
              listener: (context, state) {
                if (state is StockSuccess) {
                  Navigator.pop(context);
                  widget.nomenclatureBloc.add(LoadNomenclature());
                }
                if (state is StockError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is StockLoading
                        ? null
                        : () {
                            // Безопасный парсинг
                            final builtQty = int.tryParse(builtController.text) ?? 0;
                            final packedQty = int.tryParse(packedController.text) ?? 0;

                            final event = widget.stock == null
                                ? CreateStock(
                                    variantId: widget.variantId,
                                    colorId: 1, // Здесь должна быть логика поиска ID цвета по Hex или API
                                    built: builtQty,
                                    packed: packedQty,
                                  )
                                : UpdateStock(
                                    id: widget.stock!.id,
                                    built: builtQty,
                                    packed: packedQty,
                                  );

                            context.read<StockBloc>().add(event);
                          },
                    child: state is StockLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
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

class _StockParamTile extends StatelessWidget {
  final TextEditingController textController;
  final String title;

  const _StockParamTile({required this.textController, required this.title});

  void _updateValue(int delta) {
    int currentValue = int.tryParse(textController.text) ?? 0;
    int newValue = currentValue + delta;
    if (newValue < 0) newValue = 0;
    textController.text = newValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => _updateValue(-1),
            icon: const Icon(Icons.remove_circle_outline),
          ),
          SizedBox(
            width: 50,
            child: TextField(
              controller: textController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            onPressed: () => _updateValue(1),
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
}

class _ColorPickerTile extends StatelessWidget {
  final Color currentColor;
  final ValueChanged<Color> onColorChanged;

  const _ColorPickerTile({
    required this.currentColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('Цвет изделия'),
      subtitle: Text('HEX: #${currentColor.value.toRadixString(16).toUpperCase().substring(2)}'),
      trailing: GestureDetector(
        onTap: () => _openFullPicker(context),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: currentColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black12),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
        ),
      ),
    );
  }

  void _openFullPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выберите цвет'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: onColorChanged,
            pickerAreaHeightPercent: 0.7,
            enableAlpha: false, // Отключаем прозрачность для простоты БД
            displayThumbColor: true,
            paletteType: PaletteType.hsvWithHue,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Готово'),
          ),
        ],
      ),
    );
  }
}