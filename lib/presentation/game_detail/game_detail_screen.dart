import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/game_model.dart';
import '../../widgets/cached_image.dart';

class GameDetailScreen extends StatelessWidget {
  final GameModel game;

  const GameDetailScreen({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGameInfo(),
                const SizedBox(height: 16),
                _buildDownloadButton(),
                const SizedBox(height: 12),
                _buildAlsoAvailable(),
                const SizedBox(height: 16),
                _buildActionButtons(),
                const Divider(color: AppTheme.surfaceColor, height: 32),
                _buildRatingsSection(),
                const SizedBox(height: 16),
                _buildPlayerReview(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppTheme.backgroundColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.white),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedImage(
              imageUrl: game.banner,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppTheme.backgroundColor.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
            // Page indicator dots
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: index == 0 ? 8 : 6,
                    height: index == 0 ? 8 : 6,
                    decoration: BoxDecoration(
                      color: index == 0
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CachedIcon(
            imageUrl: game.icon,
            size: 64,
            borderRadius: 16,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  game.name,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.android, size: 14, color: AppTheme.textSecondary),
                    const SizedBox(width: 4),
                    const Icon(Icons.apple, size: 14, color: AppTheme.textSecondary),
                    const SizedBox(width: 8),
                    Text(
                      game.categories.join(' · '),
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.store,
                        size: 10,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      game.developer ?? 'Snapbreak',
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGreen,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Download',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                game.fileSize ?? '1.06 GB',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlsoAvailable() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Also available',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 12),
            Icon(Icons.play_arrow, color: AppTheme.textPrimary, size: 20),
            SizedBox(width: 8),
            Icon(Icons.apple, color: AppTheme.textPrimary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(Icons.bookmark_add_outlined, 'Wishlist'),
          _buildActionButton(Icons.star_outline, 'Played'),
          _buildActionButton(Icons.open_in_new, 'Share'),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.textPrimary, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ratings & Reviews',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_up,
                color: AppTheme.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "This game hasn't received enough ratings or reviews to display a summary.",
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'My Rating',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              ...List.generate(
                5,
                (index) => Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    Icons.star_outline,
                    color: AppTheme.textSecondary,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerReview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.pink],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Players are saying...',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Text(
                        '\u2764\uFE0F',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: game.playerReview ??
                        'The gameplay is simple yet captivating, combining survival with puzzles in an engaging way.',
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
