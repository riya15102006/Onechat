import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../auth/presentation/auth_gate.dart';

class OnboardingScreen extends StatefulWidget {
	const OnboardingScreen({super.key});

	static const String routePath = '/onboarding';
	static const String routeName = 'onboarding';

	@override
	State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
	final PageController _controller = PageController();
	int _page = 0;

	void _next() {
		if (_page < 2) {
			_controller.nextPage(
				duration: const Duration(milliseconds: 400),
				curve: Curves.easeInOut,
			);
		} else {
			context.go(AuthGateScreen.routePath);
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				decoration: BoxDecoration(gradient: AppTheme.neonGradient),
				child: SafeArea(
					child: Column(
						children: [
							Expanded(
								child: PageView(
									controller: _controller,
									onPageChanged: (i) => setState(() => _page = i),
									children: const [
										_OnbCard(
											title: 'One Hour',
											desc: 'Chat opens for 60 minutes. Make it count.',
										),
										_OnbCard(
											title: 'One Chance',
											desc: 'One random match, delivered daily.',
										),
										_OnbCard(
											title: 'One Connection',
											desc: 'Voice-first. Real vibes. Real people.',
										),
									],
								),
							),
							Padding(
								padding: const EdgeInsets.all(20),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: [
										Row(
											children: List.generate(
												3,
												(index) => Container(
													width: 10,
													height: 10,
													margin: const EdgeInsets.only(right: 8),
													decoration: BoxDecoration(
														shape: BoxShape.circle,
														color: _page == index
															? Colors.white
															: Colors.white.withOpacity(0.4),
													),
												),
											),
										),
										ElevatedButton(
											onPressed: _next,
											child: Text(_page < 2 ? 'Next' : 'Get Started'),
										),
									],
								),
							),
						],
					),
				),
			),
		);
	}
}

class _OnbCard extends StatelessWidget {
	const _OnbCard({required this.title, required this.desc});

	final String title;
	final String desc;

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.all(24.0),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Text(
						title,
						style: const TextStyle(
							fontSize: 36,
							fontWeight: FontWeight.bold,
							color: Colors.white,
						),
					),
					const SizedBox(height: 12),
					Text(
						desc,
						textAlign: TextAlign.center,
						style: TextStyle(
							fontSize: 16,
							color: Colors.white.withOpacity(0.85),
						),
					),
				],
			),
		);
	}
}