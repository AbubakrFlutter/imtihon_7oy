import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/game_model.dart';
import '../../../widgets/cached_image.dart';

class InstalledGameItem extends StatelessWidget {
  final GameModel game;
  final VoidCallback? onPlay;
  final VoidCallback? onUpdate;
  final VoidCallback? onMore;

  const InstalledGameItem({
    super.key,
    required this.game,
    this.onPlay,
    this.onUpdate,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CachedIcon(
            imageUrl: game.icon,
            size: 56,
            borderRadius: 14,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        game.name,
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (game.region != null) ...[
                      const SizedBox(width: 8),
                      _buildRegionBadge(game.region!),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  game.lastViewed != null
                      ? 'Viewed ${_formatDate(game.lastViewed!)}'
                      : 'No records',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
                if (game.hasUpdate) ...[
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: onUpdate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.textSecondary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 12,
                            color: AppTheme.primaryGreen,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Update',
                            style: TextStyle(
                              color: AppTheme.primaryGreen,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: onMore,
            icon: const Icon(
              Icons.more_vert,
              color: AppTheme.textSecondary,
            ),
          ),
          OutlinedButton(
            onPressed: onPlay,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryGreen,
              side: const BorderSide(color: AppTheme.primaryGreen),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
            child: const Text(
              'Play',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionBadge(String region) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        region,
        style: const TextStyle(
          color: AppTheme.textSecondary,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year.toString().substring(2)}';
  }
}
