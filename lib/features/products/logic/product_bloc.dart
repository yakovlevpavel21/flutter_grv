import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/products/data/models/product.dart';
import 'package:grv/features/products/data/repos/product_repo.dart';

part "product_event.dart"; 
part "product_state.dart"; 

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;


  ProductBloc(this.repository) : super(ProductLoading()) {
    on<LoadProducts>(_load);
    on<ChangeProductStock>(_changeStock);
    on<CreateProduct>(_createProduct);
    on<UpdateProduct>(_updateProduct);
    on<DeleteProduct>(_deleteProduct);
  }


  Future<void> _load(LoadProducts event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading());
      final products = await repository.fetchProducts();
      print("products loaded");
      emit(ProductLoaded(products));
    } catch (_) {
      emit(ProductError());
    }
  }


  Future<void> _changeStock(ChangeProductStock event, Emitter<ProductState> emit) async {
    try {
      await repository.changeProductQuantity(
        productId: event.productId,
        amount: event.amount,
        type: event.type,
      );
      add(LoadProducts());
    } catch (e) {
      emit(ProductError());
    }
  }

  Future<void> _createProduct(
    CreateProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await repository.createProduct(
        name: event.name,
        sku: event.sku,
        category: event.category,
        description: event.description,
      );
      add(LoadProducts());
    } catch (_) {
      emit(ProductError());
    }
  }

  Future<void> _updateProduct(
    UpdateProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await repository.updateProduct(
        id: event.id,
        name: event.name,
        sku: event.sku,
        category: event.category,
        description: event.description,
      );
      add(LoadProducts());
    } catch (_) {
      emit(ProductError());
    }
  }

  Future<void> _deleteProduct(
    DeleteProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await repository.deleteProduct(event.id);
      add(LoadProducts());
    } catch (_) {
      emit(ProductError());
    }
  }
}