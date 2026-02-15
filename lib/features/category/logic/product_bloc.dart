import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/category/data/repos/products_repo.dart';

part "product_event.dart"; 
part "product_state.dart"; 

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<CreateProduct>(_createProduct);
    on<UpdateProduct>(_updateProduct);
    on<DeleteProduct>(_deleteProduct);
  }

  Future<void> _createProduct(CreateProduct event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading());
      await repository.createProduct(event.name, event.categoryId);
      emit(ProductSuccess());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _updateProduct(UpdateProduct event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading());
      await repository.updateProduct(event.id, event.name, event.categoryId);
      emit(ProductSuccess());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _deleteProduct(DeleteProduct event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading());
      await repository.deleteProduct(event.id);
      emit(ProductSuccess());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}