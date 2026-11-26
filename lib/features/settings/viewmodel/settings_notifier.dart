import 'package:mingleph/features/auth/data/repositories/auth_repository.dart';
import 'package:mingleph/features/activity_status/data/my_activity_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/settings_notifier.g.dart';

@riverpod
class Settings extends _$Settings {
  @override
  void build() {}

  Future<void> logout() async {
    final activityStatus = ref.read(myActivityStatusProvider.notifier);
    final authRepository = ref.read(authRepositoryProvider);
    await activityStatus.goOffline();
    await authRepository.logout();
  }
}
