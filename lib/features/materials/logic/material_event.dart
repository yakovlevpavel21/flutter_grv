part of "material_bloc.dart"; 

abstract class MaterialEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoadMaterials extends MaterialEvent {}
class ChangeMaterialStock extends MaterialEvent {
  final String materialId;
  final double amount;
  final String type;


  ChangeMaterialStock(this.materialId, this.amount, this.type);


  @override
  List<Object?> get props => [materialId, amount, type];
}