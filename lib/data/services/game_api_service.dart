import '../models/game_model.dart';

class GameApiService {
  // Picsum Photos API - bepul va ishonchli rasm API
  static const String _imageBase = 'https://picsum.photos/seed';

  // O'yinlar ma'lumotlari (rasmlar picsum.photos dan)
  static final List<Map<String, dynamic>> _gamesData = [
    {'id': '1', 'name': 'Grand Theft Auto V', 'rating': 4.8, 'genres': ['Action', 'Adventure']},
    {'id': '2', 'name': 'The Witcher 3', 'rating': 4.9, 'genres': ['RPG', 'Adventure']},
    {'id': '3', 'name': 'Red Dead Redemption 2', 'rating': 4.7, 'genres': ['Action', 'Adventure']},
    {'id': '4', 'name': 'Minecraft', 'rating': 4.6, 'genres': ['Sandbox', 'Survival']},
    {'id': '5', 'name': 'Fortnite', 'rating': 4.3, 'genres': ['Battle Royale', 'Shooter']},
    {'id': '6', 'name': 'Call of Duty: Warzone', 'rating': 4.4, 'genres': ['Shooter', 'Battle Royale']},
    {'id': '7', 'name': 'Apex Legends', 'rating': 4.5, 'genres': ['Shooter', 'Battle Royale']},
    {'id': '8', 'name': 'League of Legends', 'rating': 4.2, 'genres': ['MOBA', 'Strategy']},
    {'id': '9', 'name': 'Valorant', 'rating': 4.4, 'genres': ['Shooter', 'Tactical']},
    {'id': '10', 'name': 'Cyberpunk 2077', 'rating': 4.1, 'genres': ['RPG', 'Action']},
    {'id': '11', 'name': 'Elden Ring', 'rating': 4.8, 'genres': ['RPG', 'Action']},
    {'id': '12', 'name': 'God of War', 'rating': 4.9, 'genres': ['Action', 'Adventure']},
    {'id': '13', 'name': 'Horizon Zero Dawn', 'rating': 4.6, 'genres': ['Action', 'RPG']},
    {'id': '14', 'name': 'Spider-Man', 'rating': 4.7, 'genres': ['Action', 'Adventure']},
    {'id': '15', 'name': 'FIFA 24', 'rating': 4.0, 'genres': ['Sports', 'Simulation']},
    {'id': '16', 'name': 'NBA 2K24', 'rating': 3.9, 'genres': ['Sports', 'Simulation']},
    {'id': '17', 'name': 'Assassins Creed Valhalla', 'rating': 4.3, 'genres': ['Action', 'RPG']},
    {'id': '18', 'name': 'Far Cry 6', 'rating': 4.1, 'genres': ['Shooter', 'Action']},
    {'id': '19', 'name': 'Resident Evil Village', 'rating': 4.5, 'genres': ['Horror', 'Action']},
    {'id': '20', 'name': 'Hades', 'rating': 4.7, 'genres': ['Roguelike', 'Action']},
    {'id': '21', 'name': 'Stardew Valley', 'rating': 4.8, 'genres': ['Simulation', 'RPG']},
    {'id': '22', 'name': 'Among Us', 'rating': 4.2, 'genres': ['Party', 'Social']},
    {'id': '23', 'name': 'Genshin Impact', 'rating': 4.5, 'genres': ['RPG', 'Adventure']},
    {'id': '24', 'name': 'PUBG Mobile', 'rating': 4.3, 'genres': ['Battle Royale', 'Shooter']},
    {'id': '25', 'name': 'Clash of Clans', 'rating': 4.4, 'genres': ['Strategy', 'Mobile']},
  ];

  // Story games uchun (Tavern screen)
  static final List<Map<String, dynamic>> _storyGamesData = [
    {'id': 's1', 'name': 'Wuthering Waves', 'hasNewStory': true},
    {'id': 's2', 'name': 'Zenless Zone Zero', 'hasNewStory': true},
    {'id': 's3', 'name': 'PUBG MOBILE', 'hasNewStory': false},
    {'id': 's4', 'name': 'PUBG M CN', 'hasNewStory': false},
    {'id': 's5', 'name': 'BGMI: Online', 'hasNewStory': false},
    {'id': 's6', 'name': 'Genshin Impact', 'hasNewStory': true},
    {'id': 's7', 'name': 'Honkai Star Rail', 'hasNewStory': false},
  ];

  // Postlar uchun (Tavern screen)
  static final List<Map<String, dynamic>> _postsData = [
    {
      'id': 'p1',
      'gameName': 'PUBG MOBILE: 絕地求生M',
      'title': 'Chotki',
      'authorName': 'skukur respekt',
      'authorAvatar': '',
      'createdAt': '11/11/24',
      'likes': 0,
    },
    {
      'id': 'p2',
      'gameName': 'Call of Duty®: Warzone™ Mobile',
      'title': 'Claws of Power – how I\'m building progression in my cat RTS',
      'authorName': 'Sprout',
      'authorAvatar': 'sprout',
      'createdAt': '2d',
      'likes': 24,
    },
    {
      'id': 'p3',
      'gameName': 'Genshin Impact',
      'title': 'New character build guide for beginners',
      'authorName': 'GenshinPro',
      'authorAvatar': 'genshin_pro',
      'createdAt': '3d',
      'likes': 156,
    },
    {
      'id': 'p4',
      'gameName': 'Valorant',
      'title': 'Best agent compositions for ranked',
      'authorName': 'TacticalGamer',
      'authorAvatar': 'tactical',
      'createdAt': '1d',
      'likes': 89,
    },
  ];

  static GameModel _createGame(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final name = data['name'] as String;
    final slug = name.toLowerCase().replaceAll(' ', '_').replaceAll(':', '');

    return GameModel(
      id: id,
      name: name,
      icon: '$_imageBase/${slug}_icon/200/200',
      banner: '$_imageBase/${slug}_banner/800/450',
      rating: (data['rating'] as num).toDouble(),
      categories: List<String>.from(data['genres']),
      description: 'Amazing ${(data['genres'] as List).first} game!',
      isInstalled: false,
      hasUpdate: false,
    );
  }

  // O'yinlar ro'yxatini olish
  static Future<List<GameModel>> fetchGames({int page = 1, int pageSize = 20}) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final startIndex = (page - 1) * pageSize;

    if (startIndex >= _gamesData.length) return [];

    final games = _gamesData
        .skip(startIndex)
        .take(pageSize)
        .map((data) => _createGame(data))
        .toList();

    return games;
  }

  // Mashhur o'yinlarni olish
  static Future<List<GameModel>> fetchPopularGames() async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Rating bo'yicha saralash
    final sortedData = List<Map<String, dynamic>>.from(_gamesData)
      ..sort((a, b) => (b['rating'] as num).compareTo(a['rating'] as num));

    return sortedData.take(10).map((data) => _createGame(data)).toList();
  }

  // Kun o'yini
  static Future<GameModel?> fetchGameOfTheDay() async {
    await Future.delayed(const Duration(milliseconds: 200));

    // Har kuni boshqa o'yin
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    final index = dayOfYear % _gamesData.length;

    return _createGame(_gamesData[index]);
  }

  // Janr bo'yicha o'yinlar
  static Future<List<GameModel>> fetchGamesByGenre(String genre) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final filteredData = _gamesData.where((data) {
      final genres = data['genres'] as List;
      return genres.any((g) => g.toString().toLowerCase().contains(genre.toLowerCase()));
    }).toList();

    return filteredData.take(10).map((data) => _createGame(data)).toList();
  }

  // O'yinlarni qidirish
  static Future<List<GameModel>> searchGames(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (query.isEmpty) return [];

    final filteredData = _gamesData.where((data) {
      final name = data['name'] as String;
      return name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return filteredData.map((data) => _createGame(data)).toList();
  }

  // ID bo'yicha o'yin
  static Future<GameModel?> fetchGameById(int id) async {
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      final data = _gamesData.firstWhere((d) => d['id'] == id.toString());
      return _createGame(data);
    } catch (e) {
      return null;
    }
  }

  // ===== TAVERN SCREEN UCHUN =====

  // Story games
  static Future<List<StoryGameData>> fetchStoryGames() async {
    await Future.delayed(const Duration(milliseconds: 200));

    return _storyGamesData.map((data) {
      final name = data['name'] as String;
      final slug = name.toLowerCase().replaceAll(' ', '_').replaceAll(':', '');
      return StoryGameData(
        id: data['id'] as String,
        name: name,
        icon: '$_imageBase/${slug}_story/200/200',
        hasNewStory: data['hasNewStory'] as bool,
      );
    }).toList();
  }

  // Postlar
  static Future<List<PostData>> fetchPosts() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _postsData.map((data) {
      final gameName = data['gameName'] as String;
      final slug = gameName.toLowerCase().replaceAll(' ', '_').replaceAll(':', '').replaceAll('®', '').replaceAll('™', '');
      final authorAvatar = data['authorAvatar'] as String;

      return PostData(
        id: data['id'] as String,
        gameName: gameName,
        gameIcon: '$_imageBase/${slug}_icon/200/200',
        bannerImage: '$_imageBase/${slug}_post/800/400',
        title: data['title'] as String,
        authorName: data['authorName'] as String,
        authorAvatar: authorAvatar.isNotEmpty ? '$_imageBase/${authorAvatar}_avatar/100/100' : '',
        createdAt: data['createdAt'] as String,
        likes: data['likes'] as int,
      );
    }).toList();
  }
}

// Story game data class
class StoryGameData {
  final String id;
  final String name;
  final String icon;
  final bool hasNewStory;

  StoryGameData({
    required this.id,
    required this.name,
    required this.icon,
    required this.hasNewStory,
  });
}

// Post data class
class PostData {
  final String id;
  final String gameName;
  final String gameIcon;
  final String bannerImage;
  final String title;
  final String authorName;
  final String authorAvatar;
  final String createdAt;
  final int likes;

  PostData({
    required this.id,
    required this.gameName,
    required this.gameIcon,
    required this.bannerImage,
    required this.title,
    required this.authorName,
    required this.authorAvatar,
    required this.createdAt,
    required this.likes,
  });
}
