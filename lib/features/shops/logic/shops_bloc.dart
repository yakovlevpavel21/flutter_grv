import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/features/shops/data/mappers/shop_mapper.dart';
import 'package:grv/features/shops/data/models/shop_item.dart';
import 'package:grv/features/shops/data/repos/shops_repo.dart';

part "shops_event.dart"; 
part "shops_state.dart"; 

class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  final ShopsRepository repository;
  List<ShopItemUi> _allItems = [];

  ShopsBloc(this.repository) : super(ShopsLoading()) {
    on<LoadShops>(_load);
  }

  Future<void> _load(LoadShops event, Emitter<ShopsState> emit) async {
    try {
      emit(ShopsLoading());
      final shops = await repository.fetchShops();
      _allItems = shops.map((s) => s.toShopUi()).toList();
      emit(ShopsLoaded(items: _allItems));
    } catch (e) {
      emit(ShopsError(e.toString()));
    }
  }
}