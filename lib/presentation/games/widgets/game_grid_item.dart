import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/game_model.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/rating_badge.dart';

class GameGridItem extends StatelessWidget {
  final GameModel game;
  final VoidCallback? onTap;

  const GameGridItem({
    super.key,
    required this.game,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedImage(
                  imageUrl: game.banner,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: RatingBadgeSmall(rating: game.rating),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            game.name,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            game.categories.join(' · '),
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 11,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
