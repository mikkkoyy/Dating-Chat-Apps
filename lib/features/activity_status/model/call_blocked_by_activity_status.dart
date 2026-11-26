import 'package:mingleph/utils/enums/activity_status.dart';

class CallBlockedByActivityStatus implements Exception {
  const CallBlockedByActivityStatus(this.status);

  final ActivityStatus status;

  @override
  String toString() => 'CallBlockedByActivityStatus(${status.wire})';
}
