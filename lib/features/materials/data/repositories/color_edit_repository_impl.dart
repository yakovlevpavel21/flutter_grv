import 'package:grv/features/materials/data/models/color_model.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';
import 'package:grv/features/materials/domain/repositories/color_edit_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ColorEditRepositoryImpl implements ColorEditRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<List<ColorEntity>> getColors() async {
    final response = await supabase
      .from('colors')
      .select('id, name, rgb');
    return (response as List)
        .map((e) => ColorModel.fromJson(e))
        .toList();
  }
  
  @override
  Future<void> createColor({
    required String name,
    required String rgb,
  }) async {
    await supabase.from('colors').insert({
      'name': name,
      'rgb': rgb,
    });
  }

  @override
  Future<void> updateColor({
    required int id,
    required String name,
    required String rgb,
  }) async {
    await supabase.from('colors').update({
      'name': name,
      'rgb': rgb,
    }).eq('id', id);
  }

  @override
  Future<void> deleteColor({required int id}) async {
    await supabase.from('colors').delete().eq('id', id);
  }
}