class HomeVariantCellUi {
  final int builtId;
  final int builtCount;
  final int packedId;
  final int packedCount;

  HomeVariantCellUi({
    required this.builtId, 
    this.builtCount = 0, 
    required this.packedId,
    this.packedCount = 0
  });
  
  bool get isEmpty => builtCount == 0 && packedCount == 0;
}