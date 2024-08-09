class PostItem {
  final int id;
  final String title;

  const PostItem({
    required this.id,
    required this.title,
  });

  factory PostItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'pblc_id': String id,
        'pblc_titulo': String title,
      } =>
        PostItem(id: int.parse(id), title: title),
      {
        'pblc_id': int id,
        'pblc_titulo': String title,
      } ||
      {
        'id': int id,
        'title': String title,
      } =>
        PostItem(id: id, title: title),
      _ =>
        throw const FormatException('Fallo al cargar el elemento publicación'),
    };
  }

  @override
  String toString() {
    return '\n<Post> {\n\tid: $id\n\ttitle: $title\n}\n';
  }
}
