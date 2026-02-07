import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/data/mappers/category_mapper.dart';
import 'package:grv/features/home/data/mappers/home_mapper.dart';
import 'package:grv/features/home/data/models/home_model.dart';
import 'package:grv/features/home/data/repos/home_repo.dart';

part "home_event.dart"; 
part "home_state.dart"; 

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  final HomeUiMapper mapper;

  HomeBloc(this.repository, this.mapper) : super(HomeLoading()) {
    on<LoadHome>(_load);
  }

  Future<void> _load(LoadHome event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());

      final dto = await repository.fetchCategories();
      final domain = dto.map((e) => e.toListItem()).toList();
      final ui = mapper.map(domain);

      emit(HomeLoaded(ui));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}