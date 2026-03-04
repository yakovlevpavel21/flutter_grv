import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/categories/domain/entities/product_entity.dart';
import 'package:grv/features/categories/domain/entities/category_entity.dart';
import 'package:grv/features/categories/domain/repositories/categories_repository.dart';

part "categories_event.dart"; 
part "categories_state.dart"; 

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository repository;
  Map<int, CategoryEntity> _allCategories = {};

  CategoriesBloc(this.repository) : super(CategoriesLoading()) {
    on<LoadCategories>(_load);
    on<SearchProducts>(_search);
  }

  Future<void> _load(LoadCategories event, Emitter<CategoriesState> emit) async {
    try {
      emit(CategoriesLoading());
      final categories = await repository.getCategories();

      _allCategories = {for (var c in categories) c.id: c};
      emit(CategoriesLoaded(
        categories: _allCategories
      ));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  void _search(SearchProducts event, Emitter<CategoriesState> emit) {
    if (state is! CategoriesLoaded) return;
    try {
      final current = state as CategoriesLoaded;
      final query = event.query.toLowerCase();

      if (query.isEmpty) {
        emit(current.copyWith(categories: _allCategories)); 
        return;
      }

      final filteredCategories = <int, CategoryEntity>{};

      for (final cat in _allCategories.values) {
        final filteredProducts = Map<int, ProductEntity>.fromEntries(
          cat.products.entries.where((entry) => 
            entry.value.name.toLowerCase().contains(query))
        );

        if (filteredProducts.isNotEmpty) {
          filteredCategories[cat.id] = cat.copyWith(products: filteredProducts);
        }
      }

      emit(current.copyWith(
        categories: filteredCategories
      ));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}