import 'package:cloud_firestore/cloud_firestore.dart';

enum MatchStatus { pending, active, matched, expired }

class OneMatch {
	OneMatch({
		required this.id,
		required this.userAId,
		required this.userBId,
		required this.createdAt,
		required this.expiresAt,
		required this.status,
		this.userALiked = false,
		this.userBLiked = false,
		this.chatRoomId,
	});

	final String id;
	final String userAId;
	final String userBId;
	final Timestamp createdAt;
	final Timestamp expiresAt;
	final MatchStatus status;
	final bool userALiked;
	final bool userBLiked;
	final String? chatRoomId;

	bool get isBothLiked => userALiked && userBLiked;

	Map<String, dynamic> toMap() => {
		'id': id,
		'userAId': userAId,
		'userBId': userBId,
		'createdAt': createdAt,
		'expiresAt': expiresAt,
		'status': status.name,
		'userALiked': userALiked,
		'userBLiked': userBLiked,
		'chatRoomId': chatRoomId,
	};

	factory OneMatch.fromMap(Map<String, dynamic> map) {
		return OneMatch(
			id: map['id'] as String,
			userAId: map['userAId'] as String,
			userBId: map['userBId'] as String,
			createdAt: (map['createdAt'] as Timestamp?) ?? Timestamp.now(),
			expiresAt: (map['expiresAt'] as Timestamp?) ?? Timestamp.now(),
			status: MatchStatus.values.firstWhere(
				(e) => e.name == (map['status'] as String? ?? 'pending'),
				orElse: () => MatchStatus.pending,
			),
			userALiked: (map['userALiked'] as bool?) ?? false,
			userBLiked: (map['userBLiked'] as bool?) ?? false,
			chatRoomId: map['chatRoomId'] as String?,
		);
	}
}