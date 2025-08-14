import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../match/presentation/daily_match_screen.dart';

class LoginScreen extends StatelessWidget {
	const LoginScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Sign in')),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						const Text('Welcome to OneChat',
							style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
						const SizedBox(height: 24),
						ElevatedButton(
							onPressed: () {
								// TODO: Implement phone auth
								context.go(DailyMatchScreen.routePath);
							},
							child: const Text('Continue with Phone'),
						),
						const SizedBox(height: 12),
						OutlinedButton(
							onPressed: () {
								// TODO: Implement Google sign-in
								context.go(DailyMatchScreen.routePath);
							},
							child: const Text('Continue with Google'),
						),
					],
				),
			),
		);
	}
}