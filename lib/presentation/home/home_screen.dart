import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imtihon_7/presentation/play/games_screen.dart';
import '../../providers/navigation_provider.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../games/play_screen.dart';
import '../tavern/tavern_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentTabIndexProvider);

    final screens = [
      const GameScreen(), // Games tab (index 0) - Games screen
      const PlayScreen(), // Play tab (index 1) - Play screen
      const Placeholder(), // Center button (index 2) - Games screen
      const TavernScreen(), // Tavern tab (index 3)
      const ProfileScreen(), // Me tab (index 4)
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(currentTabIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}
