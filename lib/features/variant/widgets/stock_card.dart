import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grv/features/variant/data/models/stock_item.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/product/data/models/variant_item.dart';
import 'package:grv/features/product/data/repos/variant_repo.dart';
import 'package:grv/features/product/logic/variant_bloc.dart';
import 'package:grv/features/product/widgets/variant_form_sheet.dart';
import 'package:grv/features/variant/widgets/stock_form_sheet.dart';
import 'package:grv/widgets/dialog_card.dart';

class StockCard extends StatelessWidget {
  final int categoryId;
  final int productId;
  final StockItemUi stock;
  const StockCard({
    super.key, 
    required this.categoryId, 
    required this.productId, 
    required this.stock
  });

  void _onEdit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => StockFormSheet(
        nomenclatureBloc: context.read<NomenclatureBloc>(),
        variantId: productId,
        stock: stock,
      ),
    );
  }

  //void _onDelete(BuildContext context) {
  //  showDialog(
  //    context: context,
  //    builder: (dialogCtx) => DialogCard(
  //      type: DialogType.warning,
  //      message: 'Ты уверен?\nВсе продукции этого инвенторя будут удалены!',
  //      button: BlocProvider(
  //        create: (_) => StockBloc(StockRepository()),
  //        child: _DeleteButton(
  //          variantId: stock.id, 
  //          onSuccess: () {
  //            Navigator.pop(dialogCtx);
  //            context.read<NomenclatureBloc>().add(LoadNomenclature());
  //          }
  //        ),
  //      ),
  //    ),
  //  );
  //}
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stock.color.name),
      trailing: Text('${stock.packed} (${stock.built})'),
      onTap: () {
        _onEdit(context);
      },
    );
  }
}

//class _DeleteButton extends StatelessWidget {
//  final int variantId;
//  final VoidCallback onSuccess;
//
//  const _DeleteButton({required this.variantId, required this.onSuccess});
//
//  @override
//  Widget build(BuildContext context) {
//    return BlocConsumer<StockBloc, StockState>(
//      listener: (context, state) {
//        if (state is StockSuccess) onSuccess();
//        if (state is StockError) {
//          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
//        }
//      },
//      builder: (context, state) {
//        if (state is StockLoading) return const CircularProgressIndicator();
//        return ElevatedButton(
//          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//          onPressed: () => context.read<StockBloc>().add(DeleteStock(id: variantId)),
//          child: const Text('Удалить', style: TextStyle(color: Colors.white)),
//        );
//      },
//    );
//  }
//}