import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/data/repositories/stock_edit_repository_impl.dart';
import 'package:grv/features/categories/domain/entities/stock_entity.dart';
import 'package:grv/features/categories/domain/enums/stock_state.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/presentation/blocs/stock/stock_bloc.dart';
import 'package:grv/widgets/base_form_sheet.dart';

class StockFormSheet extends StatefulWidget {
  final CategoriesBloc categoriesBloc;
  final StockEntity stock;

  const StockFormSheet({
    super.key,
    required this.categoriesBloc,
    required this.stock,
  });

  @override
  State<StockFormSheet> createState() => _StockFormSheetState();
}


class _StockFormSheetState extends State<StockFormSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StockBloc(
        repository: StockEditRepositoryImpl(),
        state: widget.stock.state,
        stockEntity: widget.stock,
      ),
      child: BlocListener<StockBloc, StockInitial>(
        listenWhen: (p, c) => c.status == StockStatus.success,
        listener: (context, state) {
          Navigator.pop(context);
          widget.categoriesBloc.add(LoadCategories());
        },
        child: _StockFormBody(),
      ),
    );
  }
}

class _StockFormBody extends StatefulWidget {
  const _StockFormBody();

  @override
  State<_StockFormBody> createState() => _StockFormBodyState();
}

class _StockFormBodyState extends State<_StockFormBody> {
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
          title: state.state == StockState.built ? 'Собранные' : 'Упакованные',
          isLoading: state.status == StockStatus.loading,
          canSubmit: state.canSubmit,
          onSave: () => context.read<StockBloc>().add(StockSubmitted()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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