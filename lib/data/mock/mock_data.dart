import '../models/game_model.dart';
import '../models/user_model.dart';
import '../models/notification_model.dart';
import '../models/post_model.dart';

class MockData {
  static const String _imageBase = 'https://picsum.photos/seed';

  static final UserModel currentUser = UserModel(
    id: '646979924',
    username: 'skukur respekt',
    avatarUrl: null,
    followersCount: 0,
    activitiesCount: 0,
    notificationsCount: 0,
    installedGameIds: ['pubg_kr', 'mlbb', 'pubg_global', 'memory_game'],
  );

  static final GameModel gameOfTheDay = GameModel(
    id: 'silt',
    name: 'SILT',
    icon: '$_imageBase/silt_icon/100/100',
    banner: '$_imageBase/silt_banner/400/250',
    rating: 9.2,
    categories: ['Puzzle', 'Adventure'],
    description: 'Dive into a surreal ocean abyss in an atmospheric puzzle-adventure!',
    isInstalled: false,
    hasUpdate: false,
  );

  static final List<GameModel> featuredGames = [
    GameModel(
      id: 'lone_necromancer',
      name: 'Lone Necromancer: Idle RPG',
      icon: '$_imageBase/necro_icon/100/100',
      banner: '$_imageBase/necro_banner/400/250',
      rating: 4.5,
      categories: ['Simulation'],
      description: 'Become the strongest necromancer!',
      isInstalled: false,
      hasUpdate: false,
    ),
  ];

  static final List<GameModel> allGames = [
    GameModel(
      id: 'fantasy_world',
      name: 'Fantasy World Lucky King',
      icon: '$_imageBase/fantasy_icon/100/100',
      banner: '$_imageBase/fantasy_banner/200/150',
      rating: 6.9,
      categories: ['RPG', 'Idle'],
      description: 'Build your fantasy kingdom!',
      isInstalled: false,
      hasUpdate: false,
    ),
    GameModel(
      id: 'backpacker',
      name: 'Backpacker',
      icon: '$_imageBase/backpacker_icon/100/100',
      banner: '$_imageBase/backpacker_banner/200/150',
      rating: 8.7,
      categories: ['Roguelike', 'Merge'],
      description: 'Adventure awaits!',
      isInstalled: false,
      hasUpdate: false,
    ),
    GameModel(
      id: 'bagmerge',
      name: 'BagMerge',
      icon: '$_imageBase/bagmerge_icon/100/100',
      banner: '$_imageBase/bagmerge_banner/200/150',
      rating: 8.3,
      categories: ['Merge', 'Roguelike'],
      description: 'Merge and survive!',
      isInstalled: false,
      hasUpdate: false,
    ),
    GameModel(
      id: 'relax_apocalypse',
      name: 'Relax Even in the Apocalypse',
      icon: '$_imageBase/relax_icon/100/100',
      banner: '$_imageBase/relax_banner/200/150',
      rating: 5.8,
      categories: ['Casual'],
      description: 'Stay calm in chaos!',
      isInstalled: false,
      hasUpdate: false,
    ),
    GameModel(
      id: 'monster_monster',
      name: 'MonsterMonster',
      icon: '$_imageBase/monster_icon/100/100',
      banner: '$_imageBase/monster_banner/200/150',
      rating: 6.8,
      categories: ['RPG', 'Idle'],
      description: 'Collect and battle monsters!',
      isInstalled: false,
      hasUpdate: false,
    ),
    GameModel(
      id: 'hammer_io',
      name: 'Hammer.io',
      icon: '$_imageBase/hammer_icon/100/100',
      banner: '$_imageBase/hammer_banner/200/150',
      rating: 8.5,
      categories: ['Action', 'Multiplayer'],
      description: 'Smash your opponents!',
      isInstalled: false,
      hasUpdate: false,
    ),
    GameModel(
      id: 'lucky_td',
      name: 'LuckyTD',
      icon: '$_imageBase/luckytd_icon/100/100',
      banner: '$_imageBase/luckytd_banner/200/150',
      rating: 6.9,
      categories: ['Tower Defense', 'Roguelike'],
      description: 'Defend with luck!',
      isInstalled: false,
      hasUpdate: false,
    ),
    GameModel(
      id: 'doomsday',
      name: 'Doomsday: Brave the Mons...',
      icon: '$_imageBase/doomsday_icon/100/100',
      banner: '$_imageBase/doomsday_banner/200/150',
      rating: 7.2,
      categories: ['Card', 'Anime'],
      description: 'Survive the doomsday!',
      isInstalled: false,
      hasUpdate: false,
    ),
    GameModel(
      id: 'fitness_sort',
      name: 'Fitness Sort',
      icon: '$_imageBase/fitness_icon/100/100',
      banner: '$_imageBase/fitness_banner/200/150',
      rating: 7.5,
      categories: ['Puzzle', 'Casual'],
      description: 'Sort and exercise!',
      isInstalled: false,
      hasUpdate: false,
    ),
    GameModel(
      id: 'quicksand_block',
      name: 'Quicksand Block',
      icon: '$_imageBase/quicksand_icon/100/100',
      banner: '$_imageBase/quicksand_banner/200/150',
      rating: 7.8,
      categories: ['Puzzle', 'Arcade'],
      description: 'Escape the quicksand!',
      isInstalled: false,
      hasUpdate: false,
    ),
  ];

  static final List<GameModel> installedGames = [
    GameModel(
      id: 'pubg_kr',
      name: 'PUBG Mobile',
      icon: '$_imageBase/pubg_kr_icon/100/100',
      banner: '$_imageBase/pubg_kr_banner/200/150',
      rating: 8.9,
      categories: ['Action', 'Battle Royale'],
      description: 'Battle Royale game',
      isInstalled: true,
      hasUpdate: false,
      region: 'KR',
      lastViewed: DateTime(2026, 1, 20),
    ),
    GameModel(
      id: 'mlbb',
      name: 'Mobile Legends: Bang Bang',
      icon: '$_imageBase/mlbb_icon/100/100',
      banner: '$_imageBase/mlbb_banner/200/150',
      rating: 8.5,
      categories: ['MOBA', 'Multiplayer'],
      description: '5v5 MOBA game',
      isInstalled: true,
      hasUpdate: true,
      region: 'Global',
    ),
    GameModel(
      id: 'pubg_global',
      name: 'PUBG MOBILE',
      icon: '$_imageBase/pubg_global_icon/100/100',
      banner: '$_imageBase/pubg_global_banner/200/150',
      rating: 8.8,
      categories: ['Action', 'Battle Royale'],
      description: 'Global version of PUBG',
      isInstalled: true,
      hasUpdate: false,
      region: 'Global',
    ),
    GameModel(
      id: 'memory_game',
      name: 'Memory game',
      icon: '$_imageBase/memory_icon/100/100',
      banner: '$_imageBase/memory_banner/200/150',
      rating: 7.0,
      categories: ['Puzzle', 'Casual'],
      description: 'Train your memory!',
      isInstalled: true,
      hasUpdate: false,
    ),
  ];

  static final List<NotificationModel> notifications = [
    NotificationModel(
      id: '1',
      type: NotificationType.follower,
      title: 'New Followers',
      message: 'You have new followers',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationModel(
      id: '2',
      type: NotificationType.activity,
      title: 'Activities',
      message: 'Check your recent activities',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationModel(
      id: '3',
      type: NotificationType.system,
      title: 'System Notifications',
      message: 'Important system updates',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  static Future<List<GameModel>> fetchGames() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return allGames;
  }

  static Future<List<GameModel>> fetchInstalledGames() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return installedGames;
  }

  static Future<GameModel> fetchGameOfTheDay() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return gameOfTheDay;
  }

  static Future<UserModel> fetchCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return currentUser;
  }

  static Future<List<NotificationModel>> fetchNotifications() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return notifications;
  }

  // Story games for Play screen
  static final List<StoryGame> storyGames = [
    StoryGame(
      id: 'wuthering_waves',
      name: 'Wuthering Waves',
      icon: '$_imageBase/wuthering_icon/100/100',
      hasNewStory: true,
    ),
    StoryGame(
      id: 'zenless_zone',
      name: 'Zenless Zone Zero',
      icon: '$_imageBase/zenless_icon/100/100',
      hasNewStory: true,
    ),
    StoryGame(
      id: 'pubg_mobile',
      name: 'PUBG MOBILE',
      icon: '$_imageBase/pubg_story_icon/100/100',
      hasNewStory: false,
    ),
    StoryGame(
      id: 'pubg_m_cn',
      name: 'PUBG M CN',
      icon: '$_imageBase/pubg_cn_icon/100/100',
      hasNewStory: false,
    ),
    StoryGame(
      id: 'bgmi',
      name: 'BGMI: Online',
      icon: '$_imageBase/bgmi_icon/100/100',
      hasNewStory: false,
    ),
  ];

  // Posts for Play screen
  static final List<PostModel> posts = [
    PostModel(
      id: '1',
      gameId: 'pubg_m_cn',
      gameName: 'PUBG MOBILE: \u7D55\u5730\u6C42\u751FM',
      gameIcon: '$_imageBase/pubg_cn_post/100/100',
      authorName: 'skukur respekt',
      authorAvatar: '',
      createdAt: DateTime(2024, 11, 11),
      title: 'Chotki',
      content: null,
      imageUrl: '$_imageBase/pubg_post_banner/400/200',
      likes: 0,
    ),
    PostModel(
      id: '2',
      gameId: 'cod_warzone',
      gameName: 'Call of Duty: Warzone Mobile',
      gameIcon: '$_imageBase/cod_icon/100/100',
      authorName: 'Sprout',
      authorAvatar: '$_imageBase/sprout_avatar/100/100',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      title: 'Claws of Power - how I\'m building progression in my cat RTS',
      content: null,
      imageUrl: '$_imageBase/cat_rts_banner/400/250',
      likes: 24,
    ),
  ];

  static Future<List<StoryGame>> fetchStoryGames() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return storyGames;
  }

  static Future<List<PostModel>> fetchPosts() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return posts;
  }

  static Future<GameModel?> fetchGameById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return [...allGames, ...installedGames, gameOfTheDay]
          .firstWhere((game) => game.id == id);
    } catch (e) {
      return null;
    }
  }
}
