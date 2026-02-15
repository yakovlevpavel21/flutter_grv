import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/nomenclature/data/repos/category_repo.dart';

part "category_event.dart"; 
part "category_state.dart"; 

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<CreateCategory>(_createCategory);
    on<UpdateCategory>(_updateCategory);
    on<DeleteCategory>(_deleteCategory);
  }

  Future<void> _createCategory(CreateCategory event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoading());
      await repository.createCategory(event.name);
      emit(CategorySuccess());
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> _updateCategory(UpdateCategory event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoading());
      await repository.updateCategory(event.id, event.name);
      emit(CategorySuccess());
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> _deleteCategory(DeleteCategory event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoading());
      await repository.deleteCategory(event.id);
      emit(CategorySuccess());
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}