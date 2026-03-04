import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/categories/domain/entities/variant_entity.dart';
import 'package:grv/features/categories/domain/repositories/variant_edit_repository.dart';

part "variant_event.dart"; 
part "variant_state.dart"; 

class VariantBloc extends Bloc<VariantEvent, VariantInitial> {
  final VariantEditRepository repository;

  VariantBloc({
    required this.repository, 
    required VariantEntity? variantEntity, 
    required int productId
  }) : super(VariantInitial.initial(
    variantEntity: variantEntity, 
    productId: productId,
  )) {
    on<NameChanged>(_nameChange);
    on<PartsConsumedChanged>(_partsChange);
    on<VariantSubmitted>(_submit);
    on<VariantDeleted>(_deleteVariant);
  }

  void _nameChange(NameChanged event, Emitter<VariantInitial> emit) {
    try {
      emit(state.copyWith(
        name: event.name
      ));
    } catch (e) {
      emit(state.copyWith(
        status: VariantStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  void _partsChange(PartsConsumedChanged event, Emitter<VariantInitial> emit) {
    try {
      emit(state.copyWith(
        partsConsumed: event.partsConsumed
      ));
    } catch (e) {
      emit(state.copyWith(
        status: VariantStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> _submit(VariantSubmitted event, Emitter<VariantInitial> emit) async {
    try {
      emit(state.copyWith(
        status: VariantStatus.loading
      ));
      if (state.isEditing) {
        await repository.updateVariant(
          id: state.id!,
          name: state.name, 
          partsConsumed: state.partsConsumed
        );
      } else {
        await repository.createVariant(
          productId: state.productId, 
          name: state.name, 
          partsConsumed: state.partsConsumed,
        );
      }
      emit(state.copyWith(
        status: VariantStatus.success
      ));
    } catch (e) {
      emit(state.copyWith(
        status: VariantStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> _deleteVariant(VariantDeleted event, Emitter<VariantInitial> emit) async {
    try {
      emit(state.copyWith(
        status: VariantStatus.loading
      ));
      await repository.deleteVariant(id: event.id);
      emit(state.copyWith(
        status: VariantStatus.success
      ));
    } catch (e) {
      emit(state.copyWith(
        status: VariantStatus.error,
        errorMessage: e.toString()
      ));
    }
  }
}