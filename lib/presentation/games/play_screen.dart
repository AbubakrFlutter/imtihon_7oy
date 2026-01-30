import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/game_provider.dart';
import '../../providers/navigation_provider.dart';
import 'widgets/game_grid_item.dart';
import '../game_detail/game_detail_screen.dart';

class PlayScreen extends ConsumerWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(gamesTabIndexProvider);
    final games = ref.watch(gamesProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildTabBar(ref, selectedTab),
            const SizedBox(height: 16),
            Expanded(
              child: games.when(
                data: (gameList) => GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: gameList.length,
                  itemBuilder: (context, index) {
                    final game = gameList[index];
                    return GameGridItem(
                      game: game,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => GameDetailScreen(game: game),
                          ),
                        );
                      },
                    );
                  },
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryGreen,
                  ),
                ),
                error: (error, stack) => Center(
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(color: AppTheme.textSecondary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(WidgetRef ref, int selectedIndex) {
    final tabs = ['Games', 'Recently'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: tabs.asMap().entries.map((entry) {
        final index = entry.key;
        final title = entry.value;
        final isSelected = index == selectedIndex;

        return GestureDetector(
          onTap: () {
            ref.read(gamesTabIndexProvider.notifier).state = index;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
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
                const SizedBox(height: 8),
                Container(
                  width: 40,
                  height: 3,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryGreen
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
