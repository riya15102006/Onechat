import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
	StorageService(this._storage);

	final FirebaseStorage _storage;

	Future<String> uploadVoice({
		required File file,
		required String uid,
		required String pathPrefix,
	}) async {
		final ref = _storage.ref().child('voice/$uid/$pathPrefix-${DateTime.now().millisecondsSinceEpoch}.m4a');
		final task = await ref.putFile(file, SettableMetadata(contentType: 'audio/m4a'));
		return task.ref.getDownloadURL();
	}
}