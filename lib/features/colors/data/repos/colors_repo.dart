import 'package:grv/data/models/color.dart';
import 'package:grv/data/models/shop.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ColorsRepository {
  final supabase = Supabase.instance.client;

  Future<List<ColorModel>> fetchColors() async {
    final response = await supabase
      .from('colors')
      .select('id, name, rgb');
    return (response as List).map((e) => ColorModel.fromJson(e)).toList();
  }
  
  Future<void> createColor({
    required String name,
    required String sku,
    String? category,
    String? description,
  }) async {
    await supabase.from('products').insert({
      'name': name,
      'sku': sku,
      'category': category,
      'description': description,
    });
  }

  Future<void> updateColor({
    required String id,
    required String name,
    required String sku,
    String? category,
    String? description,
  }) async {
    await supabase.from('products').update({
      'name': name,
      'sku': sku,
      'category': category,
      'description': description,
    }).eq('id', id);
  }

  Future<void> deleteColor(int id) async {
    await supabase.from('colors').delete().eq('id', id);
  }
}