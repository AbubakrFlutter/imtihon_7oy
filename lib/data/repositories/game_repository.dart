import '../models/game_model.dart';
import '../services/game_api_service.dart';

class GameRepository {
  // Barcha o'yinlar - RAWG API dan
  Future<List<GameModel>> getGames() async {
    return GameApiService.fetchGames(pageSize: 20);
  }

  // O'rnatilgan o'yinlar - RAWG API dan (mashhur o'yinlar sifatida)
  Future<List<GameModel>> getInstalledGames() async {
    final games = await GameApiService.fetchPopularGames();
    // Birinchi 4 tasini "o'rnatilgan" deb belgilaymiz
    return games.take(4).map((game) => GameModel(
      id: game.id,
      name: game.name,
      icon: game.icon,
      banner: game.banner,
      rating: game.rating,
      categories: game.categories,
      description: game.description,
      isInstalled: true,
      hasUpdate: game.rating > 4.0, // Rating 4+ bo'lsa update bor
    )).toList();
  }

  // Kun o'yini - RAWG API dan
  Future<GameModel?> getGameOfTheDay() async {
    return GameApiService.fetchGameOfTheDay();
  }

  // Kategoriya bo'yicha o'yinlar
  Future<List<GameModel>> getGamesByCategory(String category) async {
    // Kategoriya nomlarini RAWG genre sluglariga moslaymiz
    final genreMap = {
      'For you': '',
      'Arcade': 'arcade',
      'Strategy': 'strategy',
      'Casual': 'casual',
      'Action': 'action',
      'Adventure': 'adventure',
      'RPG': 'role-playing-games-rpg',
      'Puzzle': 'puzzle',
      'Racing': 'racing',
      'Sports': 'sports',
      'Simulation': 'simulation',
    };

    final genre = genreMap[category] ?? '';

    if (genre.isEmpty) {
      return GameApiService.fetchGames(pageSize: 20);
    }

    return GameApiService.fetchGamesByGenre(genre);
  }

  // O'yinlarni qidirish
  Future<List<GameModel>> searchGames(String query) async {
    if (query.isEmpty) return [];
    return GameApiService.searchGames(query);
  }

  // Mashhur o'yinlar
  Future<List<GameModel>> getPopularGames() async {
    return GameApiService.fetchPopularGames();
  }

  // ID bo'yicha o'yin
  Future<GameModel?> getGameById(int id) async {
    return GameApiService.fetchGameById(id);
  }
}
