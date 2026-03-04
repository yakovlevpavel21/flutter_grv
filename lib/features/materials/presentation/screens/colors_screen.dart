import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/materials/data/repositories/color_edit_repository_impl.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';
import 'package:grv/features/materials/presentation/blocs/color/color_bloc.dart';
import 'package:grv/features/materials/presentation/blocs/colors/colors_bloc.dart';
import 'package:grv/features/materials/presentation/widgets/color_form_sheet.dart';
import 'package:grv/widgets/dialog_card.dart';
import 'package:grv/widgets/edit_delete_menu_button.dart';
import 'package:grv/widgets/error_card.dart';

class ColorsScreen extends StatelessWidget {
  const ColorsScreen({super.key});
  
  void _onAdd(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => ColorFormSheet(colorsBloc: context.read<ColorsBloc>()),
      );
  }

  void _onEdit(BuildContext context, ColorEntity color) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ColorFormSheet(color: color, colorsBloc: context.read<ColorsBloc>()),
    );
  }
  
  void _onDelete(BuildContext context, int colorId) {
    showDialog(
      context: context,
      builder: (dialogCtx) => DialogCard(
        type: DialogType.warning,
        message: 'Надеюсь ты знаешь что делаешь!',
        button: BlocProvider(
          create: (_) => ColorBloc(
            repository: ColorEditRepositoryImpl(),
          ),
          child: _DeleteButton(
            colorId: colorId, 
            onSuccess: () {
              Navigator.pop(dialogCtx);
              context.read<ColorsBloc>().add(LoadColors());
            }
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Цвета'),
        actions: [
          IconButton(
            onPressed: () => _onAdd(context), 
            icon: Icon(Icons.add)
          ),
        ],
      ),
      body: BlocBuilder<ColorsBloc, ColorsState>(
        builder: (context, state) {
          if (state is ColorsLoading) {
            return Center(child: CircularProgressIndicator(),);
          }
          if (state is ColorsLoaded) {
            final colors = state.items;
            return ListView.builder(
              itemCount: colors.length,
              itemBuilder: (_, index) {
                final color = colors[index];
                return ListTile(
                  title: Text(color.name),
                  leading: SizedBox(
                    width: 30,
                    height: 30,
                    child: ColoredBox(color: color.color),
                  ),
                  trailing: EditDeleteMenuButton(
                    onEdit: () => _onEdit(context, color), 
                    onDelete: () => _onDelete(context, color.id)
                  ),
                );
              },
            );
          }
          if (state is ColorsError) {
            return ErrorCard(
              title: 'Ошибка', 
              description: state.message, 
              onReload: () {
                context.read<ColorsBloc>().add(LoadColors());
              }
            );
          }
          return SizedBox();
        }
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final int colorId;
  final VoidCallback onSuccess;

  const _DeleteButton({required this.colorId, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ColorBloc, ColorInitial>(
      listener: (context, state) {
        if (state.status == ColorStatus.success) onSuccess();
        if (state.status == ColorStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        if (state.status == ColorStatus.loading) return const CircularProgressIndicator();
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => context.read<ColorBloc>().add(ColorDeleted(id: colorId)),
          child: const Text('Удалить', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}