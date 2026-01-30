import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 22),
          onPressed: () => Navigator.pop(context),
          padding: const EdgeInsets.only(left: 8),
        ),
        title: Text(
          'Inbox',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white, size: 26),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          
          // New Followers
          _buildInboxItem(
            context: context,
            iconData: Icons.person_add_alt_1,
            iconColor: AppTheme.primaryGreen,
            iconBgColor: AppTheme.primaryGreen.withOpacity(0.15),
            title: 'New Followers',
            onTap: () {},
          ),
          
          // Activities
          _buildInboxItem(
            context: context,
            iconData: Icons.chat_bubble,
            iconColor: const Color(0xFFFF4D6D),
            iconBgColor: const Color(0xFFFF4D6D).withOpacity(0.15),
            title: 'Activities',
            onTap: () {},
          ),
          
          // System Notifications
          _buildInboxItem(
            context: context,
            iconData: Icons.volume_up,
            iconColor: const Color(0xFF4D9EFF),
            iconBgColor: const Color(0xFF4D9EFF).withOpacity(0.15),
            title: 'System Notifications',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildInboxItem({
    required BuildContext context,
    required IconData iconData,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[900]!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                iconData,
                color: iconColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            
            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            
            // Arrow
            Icon(
              Icons.chevron_right,
              color: Colors.grey[600],
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}
