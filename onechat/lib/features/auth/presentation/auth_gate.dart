import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../profile/presentation/profile_setup_screen.dart';
import '../../match/presentation/daily_match_screen.dart';
import 'login_screen.dart';

class AuthGateScreen extends StatelessWidget {
	const AuthGateScreen({super.key});

	static const String routePath = '/auth';
	static const String routeName = 'authGate';

	@override
	Widget build(BuildContext context) {
		return StreamBuilder<User?>(
			stream: FirebaseAuth.instance.authStateChanges(),
			builder: (context, snapshot) {
				if (snapshot.connectionState == ConnectionState.waiting) {
					return const Scaffold(body: Center(child: CircularProgressIndicator()));
				}
				final user = snapshot.data;
				if (user == null) {
					return const LoginScreen();
				}
				// TODO: Check if profile setup is complete; else go to setup
				return const DailyMatchScreen();
			},
		);
	}
}