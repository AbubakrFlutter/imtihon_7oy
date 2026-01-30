import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/game_model.dart';
import '../data/repositories/game_repository.dart';

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  return GameRepository();
});

final gamesProvider = FutureProvider<List<GameModel>>((ref) async {
  final repository = ref.watch(gameRepositoryProvider);
  return repository.getGames();
});

final installedGamesProvider = FutureProvider<List<GameModel>>((ref) async {
  final repository = ref.watch(gameRepositoryProvider);
  return repository.getInstalledGames();
});

final gameOfTheDayProvider = FutureProvider<GameModel?>((ref) async {
  final repository = ref.watch(gameRepositoryProvider);
  return repository.getGameOfTheDay();
});

// Mashhur o'yinlar - RAWG API dan
final popularGamesProvider = FutureProvider<List<GameModel>>((ref) async {
  final repository = ref.watch(gameRepositoryProvider);
  return repository.getPopularGames();
});

final selectedCategoryProvider = StateProvider<String>((ref) => 'For you');

final gamesByCategoryProvider = FutureProvider<List<GameModel>>((ref) async {
  final repository = ref.watch(gameRepositoryProvider);
  final category = ref.watch(selectedCategoryProvider);
  return repository.getGamesByCategory(category);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<GameModel>>((ref) async {
  final repository = ref.watch(gameRepositoryProvider);
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];
  return repository.searchGames(query);
});
