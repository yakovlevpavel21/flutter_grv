import 'package:equatable/equatable.dart';

class ProfileDto extends Equatable {
  final String id;
  final String fullName;
  final String role;
  final String? avatarUrl;
  final String? phone;

  const ProfileDto({
    required this.id,
    required this.fullName,
    required this.role,
    this.avatarUrl,
    this.phone,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return ProfileDto(
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