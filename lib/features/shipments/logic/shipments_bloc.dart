import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grv/data/models/category_products.dart';
import 'package:grv/features/shipments/data/repos/shipments_repo.dart';

part "shipments_event.dart"; 
part "shipments_state.dart"; 

class ShipmentsBloc extends Bloc<ShipmentsEvent, ShipmentsState> {
  final ShipmentsRepository repository;

  ShipmentsBloc(this.repository) : super(ShipmentsLoading()) {
    on<LoadShipments>(_load);
  }

  Future<void> _load(LoadShipments event, Emitter<ShipmentsState> emit) async {
    try {
      emit(ShipmentsLoading());
      
    } catch (e) {
      emit(ShipmentsError(e.toString()));
    }
  }
}