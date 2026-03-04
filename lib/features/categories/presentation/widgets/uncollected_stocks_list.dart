import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/data/repositories/stock_edit_repository_impl.dart';
import 'package:grv/features/categories/domain/entities/stock_entity.dart';
import 'package:grv/features/categories/domain/enums/stock_state.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/presentation/blocs/stock/stock_bloc.dart';
import 'package:grv/features/categories/presentation/widgets/uncollected_stock_form_sheet.dart';
import 'package:grv/features/materials/presentation/blocs/colors/colors_bloc.dart';
import 'package:grv/widgets/dialog_card.dart';
import 'package:grv/widgets/edit_delete_menu_button.dart';

class UncollectedStocksList extends StatelessWidget {
  final int categoryId;
  final int productId;
  final List<StockEntity> uncollectedStocks;
  const UncollectedStocksList({
    super.key, 
    required this.categoryId, 
    required this.productId, 
    required this.uncollectedStocks
  });

  void _onEdit(BuildContext context, StockEntity stockEntity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => UncollectedStockFormSheet(
        categoriesBloc: context.read<CategoriesBloc>(),
        colorsBloc: context.read<ColorsBloc>(),
        productId: productId,
        stock: stockEntity,
      ),
    );
  }
  
  void _onDelete(BuildContext context, int stockId) {
    showDialog(
      context: context,
      builder: (dialogCtx) => DialogCard(
        type: DialogType.warning,
        message: 'Надеюсь ты знаешь что делаешь!',
        button: BlocProvider(
          create: (_) => StockBloc(
            repository: StockEditRepositoryImpl(),
            productId: productId,
            state: StockState.raw,
          ),
          child: _DeleteButton(
            stockId: stockId, 
            onSuccess: () {
              Navigator.pop(dialogCtx);
              context.read<CategoriesBloc>().add(LoadCategories());
            }
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (uncollectedStocks.isEmpty) return const Center(child: Text('Нет изделий'));
    
    return Column(
      children: [
        ...uncollectedStocks.map((v) => ListTile(
          title: Text(v.color.name),
          subtitle: Text('Изготовлено: ${v.quantity}'),
          leading: SizedBox(
            width: 20,
            height: 20,
            child: ColoredBox(color: v.color.color)
          ),
          trailing: EditDeleteMenuButton(
            onEdit: () => _onEdit(context, v),
            onDelete: () => _onDelete(context, v.id),
          ),
        ))
      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final int stockId;
  final VoidCallback onSuccess;

  const _DeleteButton({required this.stockId, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockBloc, StockInitial>(
      listener: (context, state) {
        if (state.status == StockStatus.success) onSuccess();
        if (state.status == StockStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        if (state.status == StockStatus.loading) return const CircularProgressIndicator();
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => context.read<StockBloc>().add(StockDeleted(id: stockId)),
          child: const Text('Удалить', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}