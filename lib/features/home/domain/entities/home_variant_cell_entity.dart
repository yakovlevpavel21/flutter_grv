class HomeVariantCellEntity {
  final int stockBuiltId;
  final int builtCount;
  final int stockPackedId;
  final int packedCount;

  HomeVariantCellEntity({
    required this.stockBuiltId, 
    this.builtCount = 0, 
    required this.stockPackedId,
    this.packedCount = 0
  });
  
  bool get isEmpty => builtCount == 0 && packedCount == 0;
}