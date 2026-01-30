import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../data/services/game_api_service.dart';
import '../../data/models/game_model.dart';
import '../../widgets/cached_image.dart';
import '../inbox/inbox_screen.dart';
import '../game_detail/game_detail_screen.dart';

final gamesTabProvider = StateProvider<int>((ref) => 0);
final gamesCategoryProvider = StateProvider<int>((ref) => 0);

// Providers for RAWG API data
final gameOfDayProvider = FutureProvider<GameModel?>((ref) async {
  return GameApiService.fetchGameOfTheDay();
});

final featuredGamesProvider = FutureProvider<List<GameModel>>((ref) async {
  return GameApiService.fetchPopularGames();
});

final allGamesProvider = FutureProvider<List<GameModel>>((ref) async {
  return GameApiService.fetchGames(pageSize: 20);
});

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(gamesTabProvider);
    final selectedCategory = ref.watch(gamesCategoryProvider);
    final gameOfDay = ref.watch(gameOfDayProvider);
    final featuredGames = ref.watch(featuredGamesProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Search bar with notification icon
            SliverToBoxAdapter(child: _SearchBarWithNotification()),

            // Tab bar (Discover, Top charts, Calendar, Gamelist)
            SliverToBoxAdapter(child: _buildMainTabs(ref, selectedTab)),

            // Category chips
            SliverToBoxAdapter(
              child: _buildCategoryChips(ref, selectedCategory),
            ),

            // Game of the Day
            SliverToBoxAdapter(
              child: gameOfDay.when(
                data: (game) => game != null
                    ? _buildGameOfDay(game, context)
                    : const SizedBox.shrink(),
                loading: () => const SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ),
                error: (e, s) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Error: $e',
                      style: const TextStyle(color: AppTheme.textSecondary),
                    ),
                  ),
                ),
              ),
            ),

            // Featured games list
            featuredGames.when(
              data: (games) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildGameListItem(games[index], context),
                  childCount: games.length,
                ),
              ),
              loading: () => const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ),
              ),
              error: (e, s) => SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Error: $e',
                      style: const TextStyle(color: AppTheme.textSecondary),
                    ),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildMainTabs(WidgetRef ref, int selectedTab) {
    final tabs = ['Discover', 'Top charts', 'Calendar', 'Gamelist'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final title = entry.value;
          final isSelected = index == selectedTab;

          return Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () {
                ref.read(gamesTabProvider.notifier).state = index;
              },
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected
                          ? AppTheme.primaryGreen
                          : AppTheme.textSecondary,
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (isSelected)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryGreen,
                        shape: BoxShape.circle,
                      ),
                    )
                  else
                    const SizedBox(height: 6),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryChips(WidgetRef ref, int selectedCategory) {
    final categories = [
      'For you',
      "Editors' choice",
      'Arcade',
      'Strategy',
      'Casual',
    ];

    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                ref.read(gamesCategoryProvider.notifier).state = index;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.textPrimary : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.textPrimary
                        : AppTheme.surfaceColor,
                  ),
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: isSelected ? Colors.black : AppTheme.textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGameOfDay(GameModel game, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => GameDetailScreen(game: game),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Game of the Day badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Game of the Day',
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
              ),
            ),
            const SizedBox(height: 12),
            // Game image from API
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: game.banner.isNotEmpty
                  ? CachedImage(
                      imageUrl: game.banner,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: 200,
                      color: AppTheme.surfaceColor,
                      child: const Icon(
                        Icons.games,
                        size: 64,
                        color: AppTheme.textSecondary,
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            // Game title
            Text(
              game.name,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            // Game categories & rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  game.rating.toStringAsFixed(1),
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  game.categories.join(', '),
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameListItem(GameModel game, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => GameDetailScreen(game: game),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                // Game icon from API
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: game.icon.isNotEmpty
                      ? CachedImage(
                          imageUrl: game.icon,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 56,
                          height: 56,
                          color: AppTheme.surfaceColor,
                          child: const Icon(
                            Icons.games,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                // Game info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game.name,
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            game.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '·',
                            style: TextStyle(color: AppTheme.textSecondary),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              game.categories.isNotEmpty
                                  ? game.categories.first
                                  : 'Game',
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Download button
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primaryGreen),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Download',
                    style: TextStyle(
                      color: AppTheme.primaryGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Game banner image from API
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: game.banner.isNotEmpty
                  ? CachedImage(
                      imageUrl: game.banner,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: 180,
                      color: AppTheme.surfaceColor,
                      child: const Icon(
                        Icons.image,
                        size: 48,
                        color: AppTheme.textSecondary,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            const Divider(color: AppTheme.surfaceColor, height: 1),
          ],
        ),
      ),
    );
  }
}

// Alohida Widget - Search bar with notification
class _SearchBarWithNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
              child: Icon(
                Icons.search,
                color: AppTheme.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Search games...',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                ),
              ),
            ),
            // Notification button
            IconButton(
              onPressed: () {
                debugPrint('=== NOTIFICATION CLICKED ===');
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const InboxScreen()));
              },
              icon: const Icon(
                Icons.notifications_outlined,
                color: AppTheme.textSecondary,
                size: 22,
              ),
              padding: const EdgeInsets.all(12),
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
