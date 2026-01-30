import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../core/theme/app_theme.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: AppTheme.surfaceColor,
          highlightColor: AppTheme.cardColor,
          child: Container(
            width: width,
            height: height,
            color: AppTheme.surfaceColor,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: AppTheme.surfaceColor,
          child: const Icon(
            Icons.image_not_supported_outlined,
            color: AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

class CachedIcon extends StatelessWidget {
  final String imageUrl;
  final double size;
  final double borderRadius;

  const CachedIcon({
    super.key,
    required this.imageUrl,
    this.size = 48,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: AppTheme.surfaceColor,
          highlightColor: AppTheme.cardColor,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: const Icon(
            Icons.games,
            color: AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
