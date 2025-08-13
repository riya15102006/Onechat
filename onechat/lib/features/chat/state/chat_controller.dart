import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/models/message_model.dart';
import '../../../core/providers/providers.dart';

final chatMessagesProvider = StreamProvider.family<List<ChatMessage>, String>((ref, matchId) {
	final fs = ref.watch(firestoreServiceProvider);
	return fs.watchMessages(matchId);
});

final chatControllerProvider = Provider<ChatController>((ref) {
	return ChatController(ref);
});

class ChatController {
	ChatController(this._ref);

	final Ref _ref;

	Future<void> sendText({required String matchId, required String senderId, required String text}) async {
		final msg = ChatMessage(
			id: const Uuid().v4(),
			matchId: matchId,
			senderId: senderId,
			type: MessageType.text,
			text: text,
			sentAt: Timestamp.now(),
		);
		await _ref.read(firestoreServiceProvider).sendMessage(msg);
	}
}