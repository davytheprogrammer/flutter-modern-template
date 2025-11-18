class User {
  final String name;
  final String email;
  final String? bio;
  final DateTime? joinDate;
  final String? avatarUrl;

  User({
    required this.name,
    required this.email,
    this.bio,
    this.joinDate,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String?,
      joinDate: json['joinDate'] != null 
          ? DateTime.parse(json['joinDate'] as String)
          : null,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'bio': bio,
      'joinDate': joinDate?.toIso8601String(),
      'avatarUrl': avatarUrl,
    };
  }

  User copyWith({
    String? name,
    String? email,
    String? bio,
    DateTime? joinDate,
    String? avatarUrl,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      joinDate: joinDate ?? this.joinDate,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email, bio: $bio, joinDate: $joinDate, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.name == name &&
        other.email == email &&
        other.bio == bio &&
        other.joinDate == joinDate &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        bio.hashCode ^
        joinDate.hashCode ^
        avatarUrl.hashCode;
  }
}
