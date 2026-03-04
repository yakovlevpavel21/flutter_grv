import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';
import 'package:grv/features/materials/data/repositories/color_edit_repository_impl.dart';

part "color_event.dart"; 
part "color_state.dart"; 

class ColorBloc extends Bloc<ColorEvent, ColorInitial> {
  final ColorEditRepositoryImpl repository;

  ColorBloc({required this.repository, ColorEntity? initialColor}) 
        : super(
          ColorInitial.initial(initialColor)
        ) {
    on<ColorNameChanged>(_nameChange);
    on<ColorChanged>(_colorChange);
    on<ColorSubmitted>(_submit);
    on<ColorDeleted>(_delete);
  }

  void _nameChange(ColorNameChanged event, Emitter<ColorInitial> emit) {
    try {
      emit(state.copyWith(
        name: event.name
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ColorStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  void _colorChange(ColorChanged event, Emitter<ColorInitial> emit) {
    try {
      emit(state.copyWith(
        color: event.color
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ColorStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> _submit(ColorSubmitted event, Emitter<ColorInitial> emit) async {
    try {
      emit(state.copyWith(
        status: ColorStatus.loading,
      ));
      if (state.isEditing) {
        await repository.updateColor(
          id: state.id!, 
          name: state.name, 
          rgb: (state.color.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0')
        );
      } else {
        await repository.createColor(
          name: state.name, 
          rgb: (state.color.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0')
        );
      }
      emit(state.copyWith(
        status: ColorStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ColorStatus.error,
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> _delete(ColorDeleted event, Emitter<ColorInitial> emit) async {
    try {
      await repository.deleteColor(id: event.id);
      emit(state.copyWith(
        status: ColorStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ColorStatus.error,
        errorMessage: e.toString()
      ));
    }
  }
}