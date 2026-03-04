part of "color_bloc.dart";

enum ColorStatus { initial, loading, success, error }

class ColorInitial extends Equatable {
  final int? id;
  final String name;
  final Color color;
  final bool isEditing;
  final ColorStatus status;
  final String? errorMessage;

  const ColorInitial({
    this.id, 
    required this.name, 
    required this.color, 
    required this.isEditing,
    required this.status,
    this.errorMessage,
  });

  bool get canSubmit =>
      name.isNotEmpty;

  factory ColorInitial.initial(
    ColorEntity? colorEntity
  ) {
    return ColorInitial(
      id: colorEntity?.id, 
      name: colorEntity?.name ?? '', 
      color: colorEntity?.color ?? Colors.amber,
      isEditing: colorEntity != null,
      status: ColorStatus.initial,
    );
  }

  ColorInitial copyWith({
    int? id,
    String? name,
    Color? color,
    bool? isEditing,
    ColorStatus? status,
    String? errorMessage,
  }) {
    return ColorInitial(
      id: id ?? this.id, 
      name: name ?? this.name, 
      color: color ?? this.color,
      isEditing: isEditing ?? this.isEditing,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    id, 
    name, 
    color,
    isEditing,
    status,
    errorMessage,
  ];
}