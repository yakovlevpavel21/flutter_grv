import 'package:equatable/equatable.dart';

class ProfileInfoUi extends Equatable {
  final String title;
  final String subtitle;
  final String avatarUrl;
  final String phone;

  const ProfileInfoUi({
    required this.title,
    required this.subtitle,
    required this.avatarUrl,
    required this.phone,
  });

  @override
  List<Object?> get props => [title, subtitle, avatarUrl, phone];
}