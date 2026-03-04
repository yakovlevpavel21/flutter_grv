import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grv/features/materials/data/repositories/color_edit_repository_impl.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';
import 'package:grv/features/materials/presentation/blocs/color/color_bloc.dart';
import 'package:grv/features/materials/presentation/blocs/colors/colors_bloc.dart';
import 'package:grv/widgets/base_form_sheet.dart';

class ColorFormSheet extends StatefulWidget {
  final ColorEntity? color;
  final ColorsBloc colorsBloc;

  const ColorFormSheet({super.key, this.color, required this.colorsBloc});

  @override
  State<ColorFormSheet> createState() => _ColorFormSheetState();
}

class _ColorFormSheetState extends State<ColorFormSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: BlocProvider(
        create: (_) => ColorBloc(
          repository: ColorEditRepositoryImpl(), 
          initialColor: widget.color
        ),
        child: BlocListener<ColorBloc, ColorInitial>(
          listenWhen: (p, c) => c.status == ColorStatus.success,
          listener: (context, state) {
            Navigator.pop(context);
            widget.colorsBloc.add(LoadColors());
          },
          child: const _ColorFormBody(),
        ),
      ),
    );
  }
}

class _ColorFormBody extends StatefulWidget {
  const _ColorFormBody();

  @override
  State<_ColorFormBody> createState() => __ColorFormBodyState();
}

class __ColorFormBodyState extends State<_ColorFormBody> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final initialState = context.read<ColorBloc>().state;
    _nameController = TextEditingController(text: initialState.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorBloc, ColorInitial>(
      builder: (context, state) {
        return BaseFormSheet(
          title: state.isEditing ? 'Редактирование' : 'Добавление',
          isLoading: state.status == ColorStatus.loading,
          canSubmit: state.canSubmit,
          onSave: () => context.read<ColorBloc>().add(ColorSubmitted()),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameController,
                  onChanged: (v) => context.read<ColorBloc>().add(ColorNameChanged(name: v)),
                  decoration: const InputDecoration(labelText: 'Название', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(width: 16),
              _ColorPreviewCircle(
                color: state.color,
                onTap: () => _openFullPicker(context, state.color),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openFullPicker(BuildContext context, Color currentColor) {
    final bloc = context.read<ColorBloc>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Выберите цвет'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: (color) => bloc.add(ColorChanged(color: color)),
            pickerAreaHeightPercent: 0.7,
            enableAlpha: false,
            paletteType: PaletteType.hsvWithHue,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Готово'),
          ),
        ],
      ),
    );
  }
}


class _ColorPreviewCircle extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  const _ColorPreviewCircle({required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12, width: 2),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
          ],
        ),
        child: const Icon(Icons.colorize, color: Colors.white, size: 20),
      ),
    );
  }
}