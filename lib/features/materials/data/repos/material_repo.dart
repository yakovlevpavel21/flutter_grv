import 'package:grv/features/materials/data/models/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaterialRepository {
  final supabase = Supabase.instance.client;


  Future<List<MaterialModel>> fetchMaterials() async {
    final response = await supabase.from('materials').select();
    return (response as List).map((e) => MaterialModel.fromJson(e)).toList();
  }


  Future<void> changeMaterialQuantity({required String materialId, required double amount, required String type}) async {
    await supabase.from('material_movements').insert({
      'material_id': materialId,
      'change_amount': amount,
      'type': type,
      'user_id': supabase.auth.currentUser!.id,
    });
  }
}