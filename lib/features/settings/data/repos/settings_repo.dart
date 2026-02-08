import 'package:grv/data/models/profile_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsRepository {
  final supabase = Supabase.instance.client;
  
  Future<ProfileInfo> fetchProfile() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final userId = user.id;
      final profileResponse = await supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      return ProfileInfo.fromJson(profileResponse);
    } else {
      throw Exception('User not found');
    }
  }
}