import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
	UserProfile({
		required this.uid,
		required this.name,
		required this.age,
		required this.gender,
		required this.bio,
		required this.mood,
		required this.voiceIntroUrls,
		this.photoUrl,
		required this.locationRadiusKm,
		required this.minAgePref,
		required this.maxAgePref,
		this.fcmToken,
		Timestamp? createdAt,
		Timestamp? updatedAt,
	})  : createdAt = createdAt ?? Timestamp.now(),
			updatedAt = updatedAt ?? Timestamp.now();

	final String uid;
	final String name;
	final int age;
	final String gender; // 'Male' | 'Female' | 'Other'
	final String bio;
	final String mood; // emoji string
	final List<String> voiceIntroUrls; // 3 items
	final String? photoUrl;
	final int locationRadiusKm; // matching radius
	final int minAgePref;
	final int maxAgePref;
	final String? fcmToken;
	final Timestamp createdAt;
	final Timestamp updatedAt;

	bool get isProfileComplete =>
		name.isNotEmpty && age > 0 && bio.isNotEmpty && voiceIntroUrls.length == 3;

	Map<String, dynamic> toMap() {
		return {
			'uid': uid,
			'name': name,
			'age': age,
			'gender': gender,
			'bio': bio,
			'mood': mood,
			'voiceIntroUrls': voiceIntroUrls,
			'photoUrl': photoUrl,
			'locationRadiusKm': locationRadiusKm,
			'minAgePref': minAgePref,
			'maxAgePref': maxAgePref,
			'fcmToken': fcmToken,
			'createdAt': createdAt,
			'updatedAt': updatedAt,
		};
	}

	factory UserProfile.fromMap(Map<String, dynamic> map) {
		return UserProfile(
			uid: map['uid'] as String,
			name: (map['name'] as String?) ?? '',
			age: (map['age'] as num?)?.toInt() ?? 0,
			gender: (map['gender'] as String?) ?? 'Other',
			bio: (map['bio'] as String?) ?? '',
			mood: (map['mood'] as String?) ?? '🙂',
			voiceIntroUrls: List<String>.from(map['voiceIntroUrls'] ?? <String>[]),
			photoUrl: map['photoUrl'] as String?,
			locationRadiusKm: (map['locationRadiusKm'] as num?)?.toInt() ?? 20,
			minAgePref: (map['minAgePref'] as num?)?.toInt() ?? 18,
			maxAgePref: (map['maxAgePref'] as num?)?.toInt() ?? 35,
			fcmToken: map['fcmToken'] as String?,
			createdAt: (map['createdAt'] as Timestamp?) ?? Timestamp.now(),
			updatedAt: (map['updatedAt'] as Timestamp?) ?? Timestamp.now(),
		);
	}
}