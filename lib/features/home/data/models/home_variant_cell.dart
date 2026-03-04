class HomeVariantCellUi {
  final int builtCount;
  final int packedCount;

  HomeVariantCellUi({this.builtCount = 0, this.packedCount = 0});
  
  bool get isEmpty => builtCount == 0 && packedCount == 0;
}