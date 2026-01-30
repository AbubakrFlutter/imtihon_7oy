import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/game_provider.dart';
import '../../providers/user_provider.dart';
import '../inbox/inbox_screen.dart';
import 'widgets/installed_game_item.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final installedGames = ref.watch(installedGamesProvider);
    final selectedTab = ref.watch(selectedProfileTabProvider);
    final playTimeEnabled = ref.watch(playTimeEnabledProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, ref, currentUser),
            _buildTabBar(ref, selectedTab),
            _buildPlayTimeToggle(ref, playTimeEnabled),
            Expanded(
              child: installedGames.when(
                data: (games) => ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    final game = games[index];
                    return InstalledGameItem(
                      game: game,
                      onPlay: () {},
                      onUpdate: game.hasUpdate ? () {} : null,
                      onMore: () {},
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppTheme.surfaceColor,
        icon: const Icon(
          Icons.download,
          color: AppTheme.primaryGreen,
        ),
        label: const Text(
          'Downloads',
          style: TextStyle(
            color: AppTheme.primaryGreen,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref,
    AsyncValue currentUser,
  ) {
    return currentUser.when(
      data: (user) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFF0891B2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  user.username.isNotEmpty ? user.username[0].toUpperCase() : 'S',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID:${user.id}',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InboxScreen()),
                );
              },
              icon: const Icon(
                Icons.chevron_right,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(color: AppTheme.primaryGreen),
      ),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }

  Widget _buildTabBar(WidgetRef ref, int selectedIndex) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        itemCount: AppConstants.profileTabs.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              ref.read(selectedProfileTabProvider.notifier).state = index;
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.surfaceColor : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Text(
                AppConstants.profileTabs[index],
                style: TextStyle(
                  color: isSelected
                      ? AppTheme.textPrimary
                      : AppTheme.textSecondary,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlayTimeToggle(WidgetRef ref, bool isEnabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Text(
            'Play Time',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              ref.read(playTimeEnabledProvider.notifier).state = !isEnabled;
            },
            child: Container(
              width: 48,
              height: 26,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isEnabled ? AppTheme.primaryGreen : AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    alignment: isEnabled ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Align(
                    alignment: isEnabled ? Alignment.centerLeft : Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        isEnabled ? 'On' : 'Off',
                        style: TextStyle(
                          color: isEnabled ? Colors.black : AppTheme.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Default',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 13,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
