import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
	NotificationService(this._messaging, this._local)
		: _initializedTz = false;

	final FirebaseMessaging _messaging;
	final FlutterLocalNotificationsPlugin _local;
	bool _initializedTz;

	Future<void> init() async {
		if (Platform.isIOS) {
			await _messaging.requestPermission(alert: true, badge: true, sound: true);
		}
		await _local.initialize(const InitializationSettings(
			android: AndroidInitializationSettings('@mipmap/ic_launcher'),
			iOS: DarwinInitializationSettings(),
		));
		if (!_initializedTz) {
			tz.initializeTimeZones();
			_initializedTz = true;
		}
	}

	Future<String?> getFcmToken() => _messaging.getToken();

	Future<void> scheduleTenMinuteWarning({required DateTime expiresAtLocal}) async {
		final scheduled = expiresAtLocal.subtract(const Duration(minutes: 10));
		if (scheduled.isBefore(DateTime.now())) return;
		await _local.zonedSchedule(
			1001,
			"OneChat",
			"10 minutes left to make your move",
			tz.TZDateTime.from(scheduled, tz.local),
			const NotificationDetails(
				android: AndroidNotificationDetails('onechat', 'OneChat', importance: Importance.high, priority: Priority.high),
				iOS: DarwinNotificationDetails(),
			),
			androidAllowWhileIdle: true,
			uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
		);
	}
}