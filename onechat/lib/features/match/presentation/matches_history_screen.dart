import 'package:flutter/material.dart';

class MatchesHistoryScreen extends StatelessWidget {
	const MatchesHistoryScreen({super.key});

	static const String routePath = '/history';
	static const String routeName = 'history';

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Matches')),
			body: const Center(child: Text('Your saved matches will appear here.')),
		);
	}
}