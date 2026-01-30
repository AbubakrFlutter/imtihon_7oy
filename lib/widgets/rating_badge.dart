import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  final double? size;

  const RatingBadge({
    super.key,
    required this.rating,
    this.size,
  });

  Color get _backgroundColor {
    if (rating >= 8.0) return AppTheme.primaryGreen;
    if (rating >= 6.0) return AppTheme.ratingBadgeYellow;
    return AppTheme.textSecondary;
  }

  @override
  Widget build(BuildContext context) {
    final badgeSize = size ?? 32;
    return Container(
      width: badgeSize,
      height: badgeSize,
      decoration: BoxDecoration(
        color: _backgroundColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              size: badgeSize * 0.35,
              color: _backgroundColor,
            ),
            const SizedBox(width: 2),
            Text(
              rating.toStringAsFixed(1),
              style: TextStyle(
                color: _backgroundColor,
                fontSize: badgeSize * 0.35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingBadgeSmall extends StatelessWidget {
  final double rating;

  const RatingBadgeSmall({
    super.key,
    required this.rating,
  });

  Color get _backgroundColor {
    if (rating >= 8.0) return AppTheme.primaryGreen;
    if (rating >= 6.0) return AppTheme.ratingBadgeYellow;
    return AppTheme.textSecondary;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _backgroundColor.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 10,
            color: Colors.white,
          ),
          const SizedBox(width: 2),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
