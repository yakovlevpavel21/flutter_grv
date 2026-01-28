import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String id;
  final String fullName;
  final String role;
  final String? avatarUrl;
  final String? phone;


  const ProfileModel({
    required this.id,
    required this.fullName,
    required this.role,
    this.avatarUrl,
    this.phone,
  });


  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      fullName: json['full_name'] ?? '',
      role: json['role'],
      avatarUrl: json['avatar_url'],
      phone: json['phone'],
    );
  }


  @override
  List<Object?> get props => [id, fullName, role, avatarUrl, phone];
}