class UserModel {
  final String id;
  final String username;
  final String? avatarUrl;
  final int followersCount;
  final int activitiesCount;
  final int notificationsCount;
  final List<String> installedGameIds;

  const UserModel({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.followersCount = 0,
    this.activitiesCount = 0,
    this.notificationsCount = 0,
    this.installedGameIds = const [],
  });

  UserModel copyWith({
    String? id,
    String? username,
    String? avatarUrl,
    int? followersCount,
    int? activitiesCount,
    int? notificationsCount,
    List<String>? installedGameIds,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      followersCount: followersCount ?? this.followersCount,
      activitiesCount: activitiesCount ?? this.activitiesCount,
      notificationsCount: notificationsCount ?? this.notificationsCount,
      installedGameIds: installedGameIds ?? this.installedGameIds,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      followersCount: json['followersCount'] as int? ?? 0,
      activitiesCount: json['activitiesCount'] as int? ?? 0,
      notificationsCount: json['notificationsCount'] as int? ?? 0,
      installedGameIds: List<String>.from(json['installedGameIds'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'avatarUrl': avatarUrl,
      'followersCount': followersCount,
      'activitiesCount': activitiesCount,
      'notificationsCount': notificationsCount,
      'installedGameIds': installedGameIds,
    };
  }
}
