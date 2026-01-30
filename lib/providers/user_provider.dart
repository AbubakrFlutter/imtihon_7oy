import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/user_model.dart';
import '../data/models/notification_model.dart';
import '../data/repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final currentUserProvider = FutureProvider<UserModel>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getCurrentUser();
});

final notificationsProvider = FutureProvider<List<NotificationModel>>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getNotifications();
});

final playTimeEnabledProvider = StateProvider<bool>((ref) => false);

final selectedProfileTabProvider = StateProvider<int>((ref) => 0);
