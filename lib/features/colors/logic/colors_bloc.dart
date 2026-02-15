import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/colors/data/mappers/color_mapper.dart';
import 'package:grv/features/colors/data/models/color_item.dart';
import 'package:grv/features/colors/data/repos/colors_repo.dart';

part "colors_event.dart"; 
part "colors_state.dart"; 

class ColorsBloc extends Bloc<ColorsEvent, ColorsState> {
  final ColorsRepository repository;
  List<ColorItemUi> _allItems = [];

  ColorsBloc(this.repository) : super(ColorsLoading()) {
    on<LoadColors>(_load);
    on<DeleteColor>(_delete);
  }

  Future<void> _load(LoadColors event, Emitter<ColorsState> emit) async {
    try {
      emit(ColorsLoading());
      final shops = await repository.fetchColors();
      _allItems = shops.map((s) => s.toColorUi()).toList();
      emit(ColorsLoaded(items: _allItems));
    } catch (e) {
      emit(ColorsError(e.toString()));
    }
  }

  Future<void> _delete(DeleteColor event, Emitter<ColorsState> emit) async {
    try {
      if (state is! ColorsLoaded) return;
      
      await repository.deleteColor(event.id);
      _allItems = _allItems.where((element) => element.id != event.id).toList();
      emit(ColorsLoaded(items: _allItems));
    } catch (e) {
      emit(ColorsError(e.toString()));
    }
  }
}