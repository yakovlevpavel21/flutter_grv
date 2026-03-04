import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/categories/domain/entities/category_entity.dart';
import 'package:grv/features/categories/domain/repositories/category_edit_repository.dart';

part "category_event.dart"; 
part "category_state.dart"; 

class CategoryBloc extends Bloc<CategoryEvent, CategoryInitial> {
  final CategoryEditRepository repository;

  CategoryBloc({
    required this.repository,
    categoryEntity,
  }) : super(
    CategoryInitial.initial(
      categoryEntity: categoryEntity,
  )) {
    on<NameChanged>(_nameChange);
    on<CategorySubmitted>(_submit);
    on<DeleteCategory>(_delete);
  }

  void _nameChange(NameChanged event, Emitter<CategoryInitial> emit) {
    try {
      emit(state.copyWith(
        name: event.name
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> _submit(CategorySubmitted event, Emitter<CategoryInitial> emit) async {
    try {
      emit(state.copyWith(
        status: CategoryStatus.loading
      ));
      if (state.isEditing) {
        await repository.updateCategory(
          id: state.id!,
          name: state.name,
        );
      } else {
        await repository.createCategory(
          name: state.name, 
        );
      }
      emit(state.copyWith(
        status: CategoryStatus.success
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> _delete(DeleteCategory event, Emitter<CategoryInitial> emit) async {
    try {
      emit(state.copyWith(
        status: CategoryStatus.loading
      ));
      await repository.deleteCategory(id: event.id);
      emit(state.copyWith(
        status: CategoryStatus.success
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.error,
        errorMessage: e.toString()
      ));
    }
  }
}