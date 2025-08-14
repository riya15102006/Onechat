import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/auth/presentation/auth_gate.dart';
import '../../features/profile/presentation/profile_setup_screen.dart';
import '../../features/match/presentation/daily_match_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';
import '../../features/match/presentation/matches_history_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/purchase/presentation/purchase_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
	return GoRouter(
		initialLocation: SplashScreen.routePath,
		redirect: (context, state) {
			return null; // Auth-based redirects handled inside AuthGate
		},
		routes: [
			GoRoute(
				path: SplashScreen.routePath,
				name: SplashScreen.routeName,
				builder: (context, state) => const SplashScreen(),
			),
			GoRoute(
				path: OnboardingScreen.routePath,
				name: OnboardingScreen.routeName,
				builder: (context, state) => const OnboardingScreen(),
			),
			GoRoute(
				path: AuthGateScreen.routePath,
				name: AuthGateScreen.routeName,
				builder: (context, state) => const AuthGateScreen(),
			),
			GoRoute(
				path: ProfileSetupScreen.routePath,
				name: ProfileSetupScreen.routeName,
				builder: (context, state) => const ProfileSetupScreen(),
			),
			GoRoute(
				path: DailyMatchScreen.routePath,
				name: DailyMatchScreen.routeName,
				builder: (context, state) => const DailyMatchScreen(),
			),
			GoRoute(
				path: ChatScreen.routePath,
				name: ChatScreen.routeName,
				builder: (context, state) {
					final matchId = state.uri.queryParameters['matchId'] ?? '';
					return ChatScreen(matchId: matchId);
				},
			),
			GoRoute(
				path: MatchesHistoryScreen.routePath,
				name: MatchesHistoryScreen.routeName,
				builder: (context, state) => const MatchesHistoryScreen(),
			),
			GoRoute(
				path: SettingsScreen.routePath,
				name: SettingsScreen.routeName,
				builder: (context, state) => const SettingsScreen(),
			),
			GoRoute(
				path: PurchaseScreen.routePath,
				name: PurchaseScreen.routeName,
				builder: (context, state) => const PurchaseScreen(),
			),
		],
	);
});