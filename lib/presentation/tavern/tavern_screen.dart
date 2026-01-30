import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../data/services/game_api_service.dart';
import '../../widgets/cached_image.dart';

final tavernTabProvider = StateProvider<int>((ref) => 0);

// API dan story games
final tavernStoryGamesProvider = FutureProvider<List<StoryGameData>>((ref) async {
  return GameApiService.fetchStoryGames();
});

// API dan postlar
final tavernPostsProvider = FutureProvider<List<PostData>>((ref) async {
  return GameApiService.fetchPosts();
});

class TavernScreen extends ConsumerWidget {
  const TavernScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(tavernTabProvider);
    final storyGames = ref.watch(tavernStoryGamesProvider);
    final posts = ref.watch(tavernPostsProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // Top Bar - Following va For You
                SliverToBoxAdapter(
                  child: _buildTopBar(ref, selectedTab),
                ),
                
                // Story Games Row
                SliverToBoxAdapter(
                  child: storyGames.when(
                    data: (games) => _buildStoryGamesRow(games),
                    loading: () => const SizedBox(
                      height: 130,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ),
                    error: (error, stack) => const SizedBox.shrink(),
                  ),
                ),
                
                // Posts List
                posts.when(
                  data: (postList) => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildPostCard(postList[index], index),
                      childCount: postList.length,
                    ),
                  ),
                  loading: () => const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ),
                  ),
                  error: (error, stack) => const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  ),
                ),
                
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            ),
            
            // Add Post FAB - Unique heroTag qo'shildi
            Positioned(
              left: 16,
              bottom: 16,
              child: FloatingActionButton(
                heroTag: 'tavern_fab', // Unique tag
                onPressed: () {},
                backgroundColor: AppTheme.primaryGreen,
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Top Bar - huddi rasmda kabi
  Widget _buildTopBar(WidgetRef ref, int selectedTab) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
      child: Row(
        children: [
          // Following tab
          GestureDetector(
            onTap: () => ref.read(tavernTabProvider.notifier).state = 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Following',
                  style: TextStyle(
                    color: selectedTab == 0 ? Colors.white : Colors.grey[600],
                    fontSize: 18,
                    fontWeight: selectedTab == 0 ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                if (selectedTab == 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    height: 3,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          
          // For You tab
          GestureDetector(
            onTap: () => ref.read(tavernTabProvider.notifier).state = 1,
            child: Text(
              'For You',
              style: TextStyle(
                color: selectedTab == 1 ? Colors.white : Colors.grey[600],
                fontSize: 18,
                fontWeight: selectedTab == 1 ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          
          const Spacer(),
          
          // Filter icon
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // Story Games Row - huddi rasmda kabi
  Widget _buildStoryGamesRow(List<StoryGameData> games) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return Container(
            width: 80,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                // Game Icon with border
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: game.hasNewStory 
                              ? AppTheme.primaryGreen 
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: CachedImage(
                          imageUrl: game.icon,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Green dot for new stories
                    if (game.hasNewStory)
                      Positioned(
                        right: 2,
                        bottom: 2,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppTheme.backgroundColor, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                // Game Name
                Text(
                  game.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Post Card - huddi rasmda kabi
  Widget _buildPostCard(PostData post, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image with Game Info Overlay
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [
                // Main Banner Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedImage(
                    imageUrl: post.bannerImage,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                
                // Bottom overlay with game info
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        // Game Icon
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedImage(
                            imageUrl: post.gameIcon,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Game Name
                        Expanded(
                          child: Text(
                            post.gameName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Pause button
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Post Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              post.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Author Info and Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Author Avatar
                if (post.authorAvatar.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedImage(
                      imageUrl: post.authorAvatar,
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        post.authorName[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                
                // Author Name
                Text(
                  post.authorName,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                  ),
                ),
                
                // Date
                Text(
                  ' · ${post.createdAt}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                
                const Spacer(),
                
                // Like Icon and Count
                const Icon(
                  Icons.thumb_up_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  '${post.likes}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // More Icon
                Icon(
                  Icons.more_horiz,
                  size: 20,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
          
          // Recommendation Text (index 1)
          if (index == 1) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Because you\'re following Wuthering Waves — To La...',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
