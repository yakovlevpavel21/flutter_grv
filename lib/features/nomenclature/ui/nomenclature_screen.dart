import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/nomenclature/logic/nomenclature_bloc.dart';
import 'package:grv/features/nomenclature/widgets/categories_grid.dart';
import 'package:grv/features/nomenclature/widgets/category_form_sheet.dart';
import 'package:grv/features/nomenclature/widgets/search_tab.dart';
import 'package:grv/widgets/empty_state.dart';
import 'package:grv/widgets/error_card.dart';

class NomenclatureScreen extends StatelessWidget {
  const NomenclatureScreen({super.key});

  void _showAddCategorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (_) => CategoryFormSheet(
        nomenclatureBloc: context.read<NomenclatureBloc>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NomenclatureBloc, NomenclatureState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: (state is NomenclatureLoaded)
              ? const SearchTab()
              : const Text('Номенклатура'),
            actions: [
              if (state is NomenclatureLoaded)
                IconButton(
                  onPressed: () => _showAddCategorySheet(context), 
                  icon: const Icon(Icons.add)
                ),
            ],
          ),
          body: _buildBody(context, state),
        );
      }
    );
  }

  Widget _buildBody(BuildContext context, NomenclatureState state) {
    if (state is NomenclatureLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is NomenclatureError) {
      return ErrorCard(
        title: 'Ошибка',
        description: state.message,
        onReload: () => context.read<NomenclatureBloc>().add(LoadNomenclature()),
      );
    }

    if (state is NomenclatureLoaded) {
      final categories = state.nomenclature.categories;

      if (categories.isEmpty) {
        return const EmptyState();
      }

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: const CategoriesGrid(),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}