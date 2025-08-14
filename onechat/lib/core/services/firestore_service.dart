import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_profile.dart';
import '../models/match_model.dart';
import '../models/message_model.dart';

class FirestoreService {
	FirestoreService(this._db);

	final FirebaseFirestore _db;

	CollectionReference<Map<String, dynamic>> get _users => _db.collection('users');
	CollectionReference<Map<String, dynamic>> get _matches => _db.collection('matches');
	CollectionReference<Map<String, dynamic>> _messages(String matchId) => _matches.doc(matchId).collection('messages');

	Future<void> upsertUserProfile(UserProfile profile) async {
		await _users.doc(profile.uid).set(profile.toMap(), SetOptions(merge: true));
	}

	Future<UserProfile?> getUserProfile(String uid) async {
		final doc = await _users.doc(uid).get();
		if (!doc.exists) return null;
		return UserProfile.fromMap(doc.data()!);
	}

	Stream<UserProfile?> watchUserProfile(String uid) {
		return _users.doc(uid).snapshots().map((d) => d.exists ? UserProfile.fromMap(d.data()!) : null);
	}

	Future<void> createMatch(OneMatch m) async {
		await _matches.doc(m.id).set(m.toMap());
	}

	Stream<OneMatch?> watchMatch(String matchId) {
		return _matches.doc(matchId).snapshots().map((d) => d.exists ? OneMatch.fromMap(d.data()!) : null);
	}

	Future<void> likeMatch({required String matchId, required String userId, required bool liked}) async {
		await _db.runTransaction((tx) async {
			final ref = _matches.doc(matchId);
			final snap = await tx.get(ref);
			if (!snap.exists) return;
			final data = snap.data()!;
			final userAId = data['userAId'] as String;
			final field = userId == userAId ? 'userALiked' : 'userBLiked';
			tx.update(ref, {field: liked});
		});
	}

	Future<void> sendMessage(ChatMessage msg) async {
		await _messages(msg.matchId).doc(msg.id).set(msg.toMap());
	}

	Stream<List<ChatMessage>> watchMessages(String matchId) {
		return _messages(matchId)
			.orderBy('sentAt', descending: false)
			.snapshots()
			.map((q) => q.docs.map((d) => ChatMessage.fromMap(d.data())).toList());
	}
}