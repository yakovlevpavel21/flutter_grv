class HomeVariantCellUi {
  final int built;
  final int packed;

  HomeVariantCellUi({
    required this.built,
    required this.packed,
  });

  bool get isEmpty => built == 0 && packed == 0;
}