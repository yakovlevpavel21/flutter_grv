import 'package:grv/features/materials/domain/entities/color_entity.dart';

abstract class ColorEditRepository {
  Future<List<ColorEntity>> getColors();
  Future<void> createColor({
    required String name,
    required String rgb,
  });
  Future<void> updateColor({
    required int id,
    required String name,
    required String rgb,
  });
  Future<void> deleteColor({required int id});
}