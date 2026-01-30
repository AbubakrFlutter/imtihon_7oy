import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/game_provider.dart';
import '../../providers/navigation_provider.dart';
import 'widgets/category_chips.dart';
import 'widgets/game_of_day_card.dart';
import 'widgets/game_list_item.dart';
import 'widgets/inbox_content.dart';

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTabIndex = ref.watch(discoverTabIndexProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(context),
            const SizedBox(height: 16),
            _buildTabBar(ref, selectedTabIndex),
            const SizedBox(height: 16),
            Expanded(child: _buildTabContent(ref, selectedTabIndex)),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(WidgetRef ref, int selectedTabIndex) {
    // Gamelist tab (index 3) shows Inbox content
    if (selectedTabIndex == 3) {
      return const InboxContent();
    }

    // Other tabs show normal Discover content
    final gameOfTheDay = ref.watch(gameOfTheDayProvider);
    final games = ref.watch(gamesByCategoryProvider);

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: CategoryChips()),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: gameOfTheDay.when(
            data: (game) {
              if (game == null) {
                return const SizedBox.shrink();
              }
              return GameOfDayCard(game: game);
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(color: AppTheme.primaryGreen),
              ),
            ),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        games.when(
          data: (gameList) => SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final game = gameList[index];
              return GameListItem(game: game, onDownload: () {});
            }, childCount: gameList.length),
          ),
          loading: () => const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(color: AppTheme.primaryGreen),
              ),
            ),
          ),
          error: (error, stack) =>
              SliverToBoxAdapter(child: Center(child: Text('Error: $error'))),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Jujutsu Kaisen Phantom Parade',
                    style: TextStyle(
                      color: AppTheme.textSecondary.withValues(alpha: 0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.notifications_outlined,
            color: AppTheme.textPrimary,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(WidgetRef ref, int selectedIndex) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: AppConstants.discoverTabs.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              ref.read(discoverTabIndexProvider.notifier).state = index;
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppConstants.discoverTabs[index],
                    style: TextStyle(
                      color: isSelected
                          ? AppTheme.textPrimary
                          : AppTheme.textSecondary,
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isSelected)
                    Container(
                      width: 24,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
