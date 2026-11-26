import 'package:appwrite/appwrite.dart';
import 'package:mingleph/core/providers/appwrite_providers.dart';
import 'package:mingleph/core/services/execute_function.dart';
import 'package:mingleph/utils/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/room_join_service.g.dart';

@Riverpod(keepAlive: true)
RoomJoinService roomJoinService(Ref ref) =>
    RoomJoinService(functions: ref.watch(appwriteFunctionsProvider));

class RoomJoinService {
  RoomJoinService({required Functions functions}) : _functions = functions;

  final Functions _functions;

  Future<Map<String, dynamic>> joinRoom(String roomName, String uid) =>
      _functions.execute(
        functionId: joinRoomServiceId,
        body: {'roomName': roomName, 'uid': uid},
      );
}
