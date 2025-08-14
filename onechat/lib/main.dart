import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'app.dart';

Future<void> _initializeFirebase() async {
	await Firebase.initializeApp(
		options: DefaultFirebaseOptions.currentPlatform,
	);
}

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await _initializeFirebase();
	runZonedGuarded(
		() => runApp(const ProviderScope(child: OneChatApp())),
		(error, stack) {
			// In production, send to Crashlytics/Sentry
			debugPrint('Uncaught error: $error');
		},
	);
}