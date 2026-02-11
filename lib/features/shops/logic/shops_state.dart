part of "shops_bloc.dart";

abstract class ShopsState extends Equatable {
  @override
  List<Object?> get props => [];
}


class ShopsLoading extends ShopsState {}
class ShopsLoaded extends ShopsState {
  final List<ShopItemUi> items;

  ShopsLoaded({
    required this.items,
  });

  @override
  List<Object?> get props => [items];
}
class ShopsError extends ShopsState {
  final String message;
  ShopsError(this.message);
  @override
  List<Object?> get props => [message];
}