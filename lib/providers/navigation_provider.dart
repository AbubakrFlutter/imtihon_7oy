import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentTabIndexProvider = StateProvider<int>((ref) => 0);

final discoverTabIndexProvider = StateProvider<int>((ref) => 0);

final gamesTabIndexProvider = StateProvider<int>((ref) => 0);
