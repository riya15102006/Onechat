import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class VoiceService {
	VoiceService(this._record);

	final AudioRecorder _record;
	String? _path;

	Future<bool> hasPermission() => _record.hasPermission();

	Future<String> start() async {
		final dir = await getTemporaryDirectory();
		final filePath = '${dir.path}/onechat-${DateTime.now().millisecondsSinceEpoch}.m4a';
		await _record.start(
			const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000, sampleRate: 44100),
			path: filePath,
		);
		_path = filePath;
		return filePath;
	}

	Future<File?> stop() async {
		final p = await _record.stop();
		if (p == null) return null;
		return File(p);
	}

	Future<void> cancel() async {
		await _record.cancel();
	}
}