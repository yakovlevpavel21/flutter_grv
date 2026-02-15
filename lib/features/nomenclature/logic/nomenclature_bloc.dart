import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/data/models/nomenclature.dart';
import 'package:grv/features/category/data/models/product_item.dart';
import 'package:grv/features/nomenclature/data/mappers/nomenclature_mapper.dart';
import 'package:grv/features/nomenclature/data/models/category_item.dart';
import 'package:grv/features/nomenclature/data/models/nomenclature.dart';
import 'package:grv/features/nomenclature/data/repos/nomenclatures_repo.dart';

part "nomenclature_event.dart"; 
part "nomenclature_state.dart"; 

class NomenclatureBloc extends Bloc<NomenclatureEvent, NomenclatureState> {
  final NomenclatureRepository repository;
  NomenclatureUi _allNomenclature = NomenclatureUi(categories: {});

  NomenclatureBloc(this.repository) : super(NomenclatureLoading()) {
    on<LoadNomenclature>(_load);
    on<SearchNomenclature>(_search);
    on<CategorySelected>(_selectCategory);
    on<ProductSelected>(_selectProduct);
    on<VariantSelected>(_selectVariant);
  }

  Future<void> _load(LoadNomenclature event, Emitter<NomenclatureState> emit) async {
    try {
      emit(NomenclatureLoading());
      final categoryProducts = await repository.fetchNomenclature();

      final nomenclature = Nomenclature(
        categories: categoryProducts
      );
      _allNomenclature = nomenclature.toUi();
      emit(NomenclatureLoaded(
        nomenclature: _allNomenclature
      ));
    } catch (e) {
      emit(NomenclatureError(e.toString()));
    }
  }

  void _search(SearchNomenclature event, Emitter<NomenclatureState> emit) {
    if (state is! NomenclatureLoaded) return;
    try {
      final current = state as NomenclatureLoaded;
      final query = event.query.toLowerCase();

      if (query.isEmpty) {
        emit(current.copyWith(nomenclature: _allNomenclature)); 
        return;
      }

      final filteredCategories = <int, CategoryItemUi>{};

      for (final cat in _allNomenclature.categories.values) {
        final filteredProducts = Map<int, ProductItemUi>.fromEntries(
          cat.products.entries.where((entry) => 
            entry.value.name.toLowerCase().contains(query))
        );

        if (filteredProducts.isNotEmpty) {
          filteredCategories[cat.id] = cat.copyWith(products: filteredProducts);
        }
      }

      emit(current.copyWith(
        nomenclature: NomenclatureUi(categories: filteredCategories)
      ));
    } catch (e) {
      emit(NomenclatureError(e.toString()));
    }
  }

  void _selectCategory(CategorySelected event, Emitter<NomenclatureState> emit) {
    if (state is! NomenclatureLoaded) return;
    try {
      final current = state as NomenclatureLoaded;
      emit(current.copyWith(selectedCategoryId: event.id));
    } catch (e) {
      emit(NomenclatureError(e.toString()));
    }
  }

  void _selectProduct(ProductSelected event, Emitter<NomenclatureState> emit) {
    if (state is! NomenclatureLoaded) return;
    try {
      final current = state as NomenclatureLoaded;
      emit(current.copyWith(selectedProductId: event.id));
    } catch (e) {
      emit(NomenclatureError(e.toString()));
    }
  }

  void _selectVariant(VariantSelected event, Emitter<NomenclatureState> emit) {
    if (state is! NomenclatureLoaded) return;
    try {
      final current = state as NomenclatureLoaded;
      emit(current.copyWith(selectedVariantId: event.id));
    } catch (e) {
      emit(NomenclatureError(e.toString()));
    }
  }
}