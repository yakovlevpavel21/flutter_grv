import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/product/data/repos/variant_repo.dart';

part "variant_event.dart"; 
part "variant_state.dart"; 

class VariantBloc extends Bloc<VariantEvent, VariantState> {
  final VariantRepository repository;

  VariantBloc(this.repository) : super(VariantInitial()) {
    on<CreateVariant>(_createVariant);
    on<UpdateVariant>(_updateVariant);
    on<DeleteVariant>(_deleteVariant);
  }

  Future<void> _createVariant(CreateVariant event, Emitter<VariantState> emit) async {
    try {
      emit(VariantLoading());
      await repository.createVariant(event.variant, event.ratio, event.productId);
      emit(VariantSuccess());
    } catch (e) {
      emit(VariantError(e.toString()));
    }
  }

  Future<void> _updateVariant(UpdateVariant event, Emitter<VariantState> emit) async {
    try {
      emit(VariantLoading());
      await repository.updateVariant(event.id, event.variant, event.ratio);
      emit(VariantSuccess());
    } catch (e) {
      emit(VariantError(e.toString()));
    }
  }

  Future<void> _deleteVariant(DeleteVariant event, Emitter<VariantState> emit) async {
    try {
      emit(VariantLoading());
      await repository.deleteVariant(event.id);
      emit(VariantSuccess());
    } catch (e) {
      emit(VariantError(e.toString()));
    }
  }
}