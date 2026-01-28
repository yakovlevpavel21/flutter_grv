part of "material_bloc.dart";

abstract class MaterialState extends Equatable {
  @override
  List<Object?> get props => [];
}


class MaterialLoading extends MaterialState {}
class MaterialLoaded extends MaterialState {
  final List<MaterialModel> materials;


  MaterialLoaded(this.materials);


  @override
  List<Object?> get props => [materials];
}
class MaterialError extends MaterialState {}