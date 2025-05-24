class TagModel {
  final String id;
  final String name;
  final String description;

  const TagModel({
    this.id = '',
    required this.name,
    this.description = '',
  });
}
