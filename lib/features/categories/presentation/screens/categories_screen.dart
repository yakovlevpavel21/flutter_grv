import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grv/features/categories/presentation/blocs/categories/categories_bloc.dart';
import 'package:grv/features/categories/presentation/widgets/categories_grid.dart';
import 'package:grv/features/categories/presentation/widgets/category_form_sheet.dart';
import 'package:grv/features/categories/presentation/widgets/search_tab.dart';
import 'package:grv/widgets/empty_state.dart';
import 'package:grv/widgets/error_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _showAddCategorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (_) => CategoryFormSheet(
        categoriesBloc: context.read<CategoriesBloc>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: (state is CategoriesLoaded)
              ? const SearchTab()
              : const Text('Категории'),
            actions: [
              if (state is CategoriesLoaded)
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

  Widget _buildBody(BuildContext context, CategoriesState state) {
    if (state is CategoriesLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CategoriesError) {
      return ErrorCard(
        title: 'Ошибка',
        description: state.message,
        onReload: () => context.read<CategoriesBloc>().add(LoadCategories()),
      );
    }

    if (state is CategoriesLoaded) {
      final categories = state.categories;

      return RefreshIndicator(
        onRefresh: () async {
          final completer = Completer<void>();
          context.read<CategoriesBloc>().add(LoadCategories(completer: completer));
          return completer.future;
        },
        child: categories.isEmpty 
            ? const EmptyState() 
            : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: const CategoriesGrid(),
                  ),
                ),
              ),
            ),
      );
    }

    return const SizedBox.shrink();
  }
}