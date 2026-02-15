import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/data/models/category_products.dart';
import 'package:grv/features/home/data/mappers/home_mapper.dart';
import 'package:grv/features/home/data/repos/home_repo.dart';

part "home_event.dart"; 
part "home_state.dart"; 

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  final HomeUiMapper mapper;

  HomeBloc(this.repository, this.mapper) : super(HomeLoading()) {
    on<LoadHome>(_load);
    on<PackedCountChanged>(_packedChanged);
  }

  Future<void> _load(LoadHome event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());
      final domain = await repository.fetchCategories();
      final ui = mapper.map(domain);

      emit(HomeLoaded(domain));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _packedChanged(PackedCountChanged event, Emitter<HomeState> emit) {
    if (state is! HomeLoaded) return;

    final current = state as HomeLoaded;

    

  }
}