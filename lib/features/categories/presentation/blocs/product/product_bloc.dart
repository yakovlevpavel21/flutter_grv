import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/categories/domain/entities/product_entity.dart';
import 'package:grv/features/categories/domain/repositories/product_edit_repository.dart';

part "product_event.dart"; 
part "product_state.dart"; 

class ProductBloc extends Bloc<ProductEvent, ProductInitial> {
  final ProductEditRepository repository;

  ProductBloc({
    required this.repository,
    productEntity,
    required categoryId
  }) : super(
    ProductInitial.initial(
      productEntity: productEntity,
      categoryId: categoryId
  )) {
    on<NameChanged>(_nameChange);
    on<ProductSubmitted>(_submit);
    on<DeleteProduct>(_delete);
  }

  void _nameChange(NameChanged event, Emitter<ProductInitial> emit) {
    try {
      emit(state.copyWith(
        name: event.name
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> _submit(ProductSubmitted event, Emitter<ProductInitial> emit) async {
    try {
      emit(state.copyWith(
        status: ProductStatus.loading
      ));
      if (state.isEditing) {
        await repository.updateProduct(
          id: state.id!,
          name: state.name,
          categoryId: state.categoryId
        );
      } else {
        await repository.createProduct(
          name: state.name, 
          categoryId: state.categoryId
        );
      }
      emit(state.copyWith(
        status: ProductStatus.success
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> _delete(DeleteProduct event, Emitter<ProductInitial> emit) async {
    try {
      emit(state.copyWith(
        status: ProductStatus.loading
      ));
      await repository.deleteProduct(id: event.id);
      emit(state.copyWith(
        status: ProductStatus.success
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: e.toString()
      ));
    }
  }
}