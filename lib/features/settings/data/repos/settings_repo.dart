import 'package:grv/data/dtos/profile.dart';
import 'package:grv/data/mappers/profile_mapper.dart';
import 'package:grv/data/models/profile_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsRepository {
  final supabase = Supabase.instance.client;
  
  Future<ProfileInfoUi> fetchProfile() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final userId = user.id;
      final profileResponse = await supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      return ProfileDto.fromJson(profileResponse).toInfoUi();
    } else {
      throw Exception('User not found');
    }
  }
}