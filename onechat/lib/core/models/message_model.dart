import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, voice }

class ChatMessage {
	ChatMessage({
		required this.id,
		required this.matchId,
		required this.senderId,
		required this.type,
		this.text,
		this.voiceUrl,
		this.voiceDurationMs,
		required this.sentAt,
	});

	final String id;
	final String matchId;
	final String senderId;
	final MessageType type;
	final String? text;
	final String? voiceUrl;
	final int? voiceDurationMs;
	final Timestamp sentAt;

	Map<String, dynamic> toMap() => {
		'id': id,
		'matchId': matchId,
		'senderId': senderId,
		'type': type.name,
		'text': text,
		'voiceUrl': voiceUrl,
		'voiceDurationMs': voiceDurationMs,
		'sentAt': sentAt,
	};

	factory ChatMessage.fromMap(Map<String, dynamic> map) {
		return ChatMessage(
			id: map['id'] as String,
			matchId: map['matchId'] as String,
			senderId: map['senderId'] as String,
			type: MessageType.values.firstWhere(
				(e) => e.name == (map['type'] as String? ?? 'text'),
				orElse: () => MessageType.text,
			),
			text: map['text'] as String?,
			voiceUrl: map['voiceUrl'] as String?,
			voiceDurationMs: (map['voiceDurationMs'] as num?)?.toInt(),
			sentAt: (map['sentAt'] as Timestamp?) ?? Timestamp.now(),
		);
	}
}