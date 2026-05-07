import 'package:flutter_riverpod/flutter_riverpod.dart';

class SyncService {
  Future<void> syncData() async {
    // Simulate network delay for syncing offline data to the cloud
    await Future.delayed(const Duration(seconds: 2));
  }
}

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService();
});

final isSyncingProvider = StateProvider<bool>((ref) => false);
