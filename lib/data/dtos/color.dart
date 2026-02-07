import 'package:equatable/equatable.dart';

class ColorDto extends Equatable {
  final int id;
  final String name;
  final String rgb;


  const ColorDto({
    required this.id,
    required this.name,
    required this.rgb,
  });


  factory ColorDto.fromJson(Map<String, dynamic> json) {
    return ColorDto(
      id: json['id'],
      name: json['name'],
      rgb: json['rgb'],
    );
  }


  @override
  List<Object?> get props => [id, name, rgb];
}