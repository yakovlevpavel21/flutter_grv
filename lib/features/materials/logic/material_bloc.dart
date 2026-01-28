import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/materials/data/models/material.dart';
import 'package:grv/features/materials/data/repos/material_repo.dart';

part "material_event.dart"; 
part "material_state.dart"; 

class MaterialBloc extends Bloc<MaterialEvent, MaterialState> {
  final MaterialRepository repository;


  MaterialBloc(this.repository) : super(MaterialLoading()) {
    on<LoadMaterials>(_load);
    on<ChangeMaterialStock>(_changeStock);
  }


  Future<void> _load(LoadMaterials event, Emitter<MaterialState> emit) async {
    try {
      emit(MaterialLoading());
      final mats = await repository.fetchMaterials();
      emit(MaterialLoaded(mats));
    } catch (_) {
      emit(MaterialError());
    }
  }


  Future<void> _changeStock(ChangeMaterialStock event, Emitter<MaterialState> emit) async {
    try {
      await repository.changeMaterialQuantity(
        materialId: event.materialId,
        amount: event.amount,
        type: event.type,
      );


      add(LoadMaterials());
    } catch (_) {
      emit(MaterialError());
    }
  }
}