class PostModel {
  final String id;
  final String gameId;
  final String gameName;
  final String gameIcon;
  final String authorName;
  final String authorAvatar;
  final DateTime createdAt;
  final String title;
  final String? content;
  final String? imageUrl;
  final int likes;
  final bool isLiked;

  const PostModel({
    required this.id,
    required this.gameId,
    required this.gameName,
    required this.gameIcon,
    required this.authorName,
    required this.authorAvatar,
    required this.createdAt,
    required this.title,
    this.content,
    this.imageUrl,
    this.likes = 0,
    this.isLiked = false,
  });

  PostModel copyWith({
    String? id,
    String? gameId,
    String? gameName,
    String? gameIcon,
    String? authorName,
    String? authorAvatar,
    DateTime? createdAt,
    String? title,
    String? content,
    String? imageUrl,
    int? likes,
    bool? isLiked,
  }) {
    return PostModel(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      gameName: gameName ?? this.gameName,
      gameIcon: gameIcon ?? this.gameIcon,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

class StoryGame {
  final String id;
  final String name;
  final String icon;
  final bool hasNewStory;

  const StoryGame({
    required this.id,
    required this.name,
    required this.icon,
    this.hasNewStory = false,
  });
}
