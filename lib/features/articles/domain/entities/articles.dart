class Articles {
  String? id, createdAt, avatar;
  final String title, desc;

  Articles({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.avatar,
    required this.desc,
  });

  Articles.add({
    required this.title,
    required this.desc,
  });

  Articles.update({
    required this.id,
    required this.title,
    required this.desc,
  });
}
