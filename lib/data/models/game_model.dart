class GameModel {
  final String id;
  final String name;
  final String icon;
  final String banner;
  final double rating;
  final List<String> categories;
  final String description;
  final bool isInstalled;
  final bool hasUpdate;
  final String? region;
  final DateTime? lastViewed;
  final String? developer;
  final String? fileSize;
  final List<String>? platforms;
  final List<String>? screenshots;
  final int reviewCount;
  final String? playerReview;

  const GameModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.banner,
    required this.rating,
    required this.categories,
    required this.description,
    this.isInstalled = false,
    this.hasUpdate = false,
    this.region,
    this.lastViewed,
    this.developer,
    this.fileSize,
    this.platforms,
    this.screenshots,
    this.reviewCount = 0,
    this.playerReview,
  });

  GameModel copyWith({
    String? id,
    String? name,
    String? icon,
    String? banner,
    double? rating,
    List<String>? categories,
    String? description,
    bool? isInstalled,
    bool? hasUpdate,
    String? region,
    DateTime? lastViewed,
    String? developer,
    String? fileSize,
    List<String>? platforms,
    List<String>? screenshots,
    int? reviewCount,
    String? playerReview,
  }) {
    return GameModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      banner: banner ?? this.banner,
      rating: rating ?? this.rating,
      categories: categories ?? this.categories,
      description: description ?? this.description,
      isInstalled: isInstalled ?? this.isInstalled,
      hasUpdate: hasUpdate ?? this.hasUpdate,
      region: region ?? this.region,
      lastViewed: lastViewed ?? this.lastViewed,
      developer: developer ?? this.developer,
      fileSize: fileSize ?? this.fileSize,
      platforms: platforms ?? this.platforms,
      screenshots: screenshots ?? this.screenshots,
      reviewCount: reviewCount ?? this.reviewCount,
      playerReview: playerReview ?? this.playerReview,
    );
  }

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      banner: json['banner'] as String,
      rating: (json['rating'] as num).toDouble(),
      categories: List<String>.from(json['categories'] as List),
      description: json['description'] as String,
      isInstalled: json['isInstalled'] as bool? ?? false,
      hasUpdate: json['hasUpdate'] as bool? ?? false,
      region: json['region'] as String?,
      lastViewed: json['lastViewed'] != null
          ? DateTime.parse(json['lastViewed'] as String)
          : null,
      developer: json['developer'] as String?,
      fileSize: json['fileSize'] as String?,
      platforms: json['platforms'] != null
          ? List<String>.from(json['platforms'] as List)
          : null,
      screenshots: json['screenshots'] != null
          ? List<String>.from(json['screenshots'] as List)
          : null,
      reviewCount: json['reviewCount'] as int? ?? 0,
      playerReview: json['playerReview'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'banner': banner,
      'rating': rating,
      'categories': categories,
      'description': description,
      'isInstalled': isInstalled,
      'hasUpdate': hasUpdate,
      'region': region,
      'lastViewed': lastViewed?.toIso8601String(),
      'developer': developer,
      'fileSize': fileSize,
      'platforms': platforms,
      'screenshots': screenshots,
      'reviewCount': reviewCount,
      'playerReview': playerReview,
    };
  }
}
