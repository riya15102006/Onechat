import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../onboarding/onboarding_screen.dart';
import '../auth/presentation/auth_gate.dart';

class SplashScreen extends StatefulWidget {
	const SplashScreen({super.key});

	static const String routePath = '/';
	static const String routeName = 'splash';

	@override
	State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
	with SingleTickerProviderStateMixin {
	late final AnimationController _controller;
	late final Animation<double> _scale;

	@override
	void initState() {
		super.initState();
		_controller = AnimationController(
			vsync: this,
			duration: const Duration(milliseconds: 1200),
		);
		_scale = Tween<double>(begin: 0.9, end: 1.05)
			.chain(CurveTween(curve: Curves.easeInOut))
			.animate(_controller);
		_controller.repeat(reverse: true);

		Timer(const Duration(milliseconds: 1400), () {
			// TODO: check onboarding pref; for now route to AuthGate
			if (!mounted) return;
			context.go(AuthGateScreen.routePath);
		});
	}

	@override
	void dispose() {
		_controller.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				decoration: BoxDecoration(gradient: AppTheme.neonGradient),
				child: Center(
					child: ScaleTransition(
						scale: _scale,
						child: const Text(
							'OneChat',
							style: TextStyle(
								fontSize: 42,
								fontWeight: FontWeight.w800,
								color: Colors.white,
							),
						),
					),
				),
			),
		);
	}
}