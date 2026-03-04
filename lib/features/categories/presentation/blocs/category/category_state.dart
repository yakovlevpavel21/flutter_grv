part of "category_bloc.dart";

enum CategoryStatus { initial, loading, success, error }

class CategoryInitial extends Equatable {
  final int? id;
  final String name;
  final bool isEditing;
  final CategoryStatus status;
  final String? errorMessage;

  const CategoryInitial({
    this.id,
    required this.name,
    required this.isEditing,
    required this.status,
    this.errorMessage,
  });

  bool get canSubmit =>
      name.isNotEmpty;

  factory CategoryInitial.initial({
    required CategoryEntity? categoryEntity,
  }) {
    return CategoryInitial(
      id: categoryEntity?.id, 
      name: categoryEntity?.name ?? '',
      isEditing: categoryEntity != null,
      status: CategoryStatus.initial,
    );
  }

  CategoryInitial copyWith({
    int? id,
    String? name,
    bool? isEditing,
    CategoryStatus? status,
    String? errorMessage,
  }) {
    return CategoryInitial(
      id: id ?? this.id, 
      name: name ?? this.name,
      isEditing: isEditing ?? this.isEditing,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    isEditing,
    status,
    errorMessage,
  ];
}
