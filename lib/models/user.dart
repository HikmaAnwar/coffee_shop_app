class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final List<String> favoriteCoffeeIds;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.favoriteCoffeeIds = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      favoriteCoffeeIds: List<String>.from(json['favoriteCoffeeIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'favoriteCoffeeIds': favoriteCoffeeIds,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    List<String>? favoriteCoffeeIds,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      favoriteCoffeeIds: favoriteCoffeeIds ?? this.favoriteCoffeeIds,
    );
  }
}
