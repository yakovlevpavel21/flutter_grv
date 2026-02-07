part of "shipments_bloc.dart";

abstract class ShipmentsState extends Equatable {
  @override
  List<Object?> get props => [];
}


class ShipmentsLoading extends ShipmentsState {}
class ShipmentsLoaded extends ShipmentsState {
  final List<CategoryProducts> categories;


  ShipmentsLoaded(this.categories);


  @override
  List<Object?> get props => [categories];
}
class ShipmentsError extends ShipmentsState {
  final String message;
  ShipmentsError(this.message);
  @override
  List<Object?> get props => [message];
}