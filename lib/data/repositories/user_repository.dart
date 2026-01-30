import '../models/user_model.dart';
import '../models/notification_model.dart';
import '../mock/mock_data.dart';

class UserRepository {
  Future<UserModel> getCurrentUser() async {
    return MockData.fetchCurrentUser();
  }

  Future<List<NotificationModel>> getNotifications() async {
    return MockData.fetchNotifications();
  }

  Future<int> getFollowersCount() async {
    final user = await MockData.fetchCurrentUser();
    return user.followersCount;
  }

  Future<int> getActivitiesCount() async {
    final user = await MockData.fetchCurrentUser();
    return user.activitiesCount;
  }
}
