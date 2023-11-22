import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id, createdAt, name, avatar;

  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.empty() : this(id: "1", createdAt: "", name: "", avatar: "");

  @override
  List<Object> get props => [id,name,avatar];
}