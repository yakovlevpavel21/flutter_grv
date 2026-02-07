import 'package:grv/data/dtos/profile.dart';
import 'package:grv/data/models/profile_info.dart';

extension ProfileUiMapper on ProfileDto {
  ProfileInfoUi toInfoUi() {
    return ProfileInfoUi(
      title: fullName,
      subtitle: 'Роль: $role',
      avatarUrl: avatarUrl ?? '',
      phone: phone ?? 'Номер отсутствует'
    );
  }
}