import 'package:equatable/equatable.dart';

class ProfileInfo extends Equatable {
  final String id;
  final String fullName;
  final String role;
  final String? avatarUrl;
  final String? phone;

  const ProfileInfo({
    required this.id,
    required this.fullName,
    required this.role,
    this.avatarUrl,
    this.phone,
  });

  factory ProfileInfo.fromJson(Map<String, dynamic> json) {
    return ProfileInfo(
      id: json['id'],
      fullName: json['full_name'],
      role: json['role'],
      avatarUrl: json['avatar_url'],
      phone: json['phone'],
    );
  }

  @override
  List<Object?> get props => [id, fullName, role, avatarUrl, phone];
}