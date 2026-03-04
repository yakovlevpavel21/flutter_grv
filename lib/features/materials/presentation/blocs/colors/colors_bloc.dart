import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';
import 'package:grv/features/materials/data/repositories/color_edit_repository_impl.dart';

part "colors_event.dart"; 
part "colors_state.dart"; 

class ColorsBloc extends Bloc<ColorsEvent, ColorsState> {
  final ColorEditRepositoryImpl repository;

  ColorsBloc(this.repository) : super(ColorsInitial()) {
    on<LoadColors>(_load);
  }

  Future<void> _load(LoadColors event, Emitter<ColorsState> emit) async {
    try {
      emit(ColorsLoading());
      final colors = await repository.getColors();
      emit(ColorsLoaded(items: colors));
    } catch (e) {
      emit(ColorsError(e.toString()));
    } finally {
      event.completer?.complete();
    }
  }
}