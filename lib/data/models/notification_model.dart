enum NotificationType {
  follower,
  activity,
  system,
}

class NotificationModel {
  final String id;
  final NotificationType type;
  final String title;
  final String? message;
  final DateTime createdAt;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    this.message,
    required this.createdAt,
    this.isRead = false,
  });

  NotificationModel copyWith({
    String? id,
    NotificationType? type,
    String? title,
    String? message,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NotificationType.system,
      ),
      title: json['title'] as String,
      message: json['message'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }
}
