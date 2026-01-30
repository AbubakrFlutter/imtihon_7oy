import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class InboxContent extends StatelessWidget {
  const InboxContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Inbox header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Go back to Discover tab
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppTheme.textPrimary,
                  size: 20,
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Inbox',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Icon(
                Icons.more_horiz,
                color: AppTheme.textPrimary,
                size: 24,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Inbox items
        _buildInboxItem(
          icon: Icons.person_add,
          iconColor: AppTheme.primaryGreen,
          iconBgColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
          title: 'New Followers',
        ),
        _buildInboxItem(
          icon: Icons.campaign,
          iconColor: Colors.pinkAccent,
          iconBgColor: Colors.pinkAccent.withValues(alpha: 0.2),
          title: 'Activities',
        ),
        _buildInboxItem(
          icon: Icons.volume_up,
          iconColor: Colors.blue,
          iconBgColor: Colors.blue.withValues(alpha: 0.2),
          title: 'System Notifications',
        ),
      ],
    );
  }

  Widget _buildInboxItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.surfaceColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppTheme.textSecondary,
          ),
        ],
      ),
    );
  }
}
