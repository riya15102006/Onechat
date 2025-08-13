import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';

import '../services/storage_service.dart';
import '../services/voice_service.dart';
import '../services/notification_service.dart';

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);
final storageServiceProvider = Provider<StorageService>((ref) => StorageService(ref.watch(firebaseStorageProvider)));

final audioRecorderProvider = Provider<AudioRecorder>((ref) => AudioRecorder());
final voiceServiceProvider = Provider<VoiceService>((ref) => VoiceService(ref.watch(audioRecorderProvider)));

final localNotificationsProvider = Provider<FlutterLocalNotificationsPlugin>((ref) => FlutterLocalNotificationsPlugin());
final notificationServiceProvider = Provider<NotificationService>((ref) => NotificationService(
	FirebaseMessaging.instance,
	ref.watch(localNotificationsProvider),
));