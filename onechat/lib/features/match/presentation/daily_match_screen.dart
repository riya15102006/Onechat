import 'dart:async';

import 'package:flutter/material.dart';

class DailyMatchScreen extends StatefulWidget {
	const DailyMatchScreen({super.key});

	static const String routePath = '/daily';
	static const String routeName = 'dailyMatch';

	@override
	State<DailyMatchScreen> createState() => _DailyMatchScreenState();
}

class _DailyMatchScreenState extends State<DailyMatchScreen> {
	Duration remaining = const Duration(minutes: 60);
	Timer? _timer;

	@override
	void initState() {
		super.initState();
		_timer = Timer.periodic(const Duration(seconds: 1), (_) {
			setState(() {
				if (remaining.inSeconds > 0) {
					remaining -= const Duration(seconds: 1);
				}
			});
		});
	}

	@override
	void dispose() {
		_timer?.cancel();
		super.dispose();
	}

	String _format(Duration d) {
		final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
		final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
		return '$m:$s';
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Today\'s Match')),
			body: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					children: [
						Expanded(
							child: Card(
								child: Padding(
									padding: const EdgeInsets.all(16),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											Row(
												mainAxisAlignment: MainAxisAlignment.spaceBetween,
												children: [
													const Text('Mystery Match', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
													AnimatedScale(
														scale: 1 + (remaining.inSeconds % 2 == 0 ? 0.06 : 0),
														duration: const Duration(milliseconds: 500),
														child: Chip(label: Text(_format(remaining))),
													),
												],
											),
											const SizedBox(height: 16),
											const Text('Bio: "Let\'s vibe over music and midnight chai."'),
											const SizedBox(height: 8),
											Row(
												children: const [
													Text('Mood: '),
													Text('🤗'),
													SizedBox(width: 16),
													Text('Distance: ~5 km'),
													SizedBox(width: 16),
													Text('Common: Music'),
												],
											),
										],
									),
								),
							),
						),
						Row(
							children: [
								Expanded(
									child: OutlinedButton(
										onPressed: () {},
										child: const Text('Skip'),
									),
								),
								const SizedBox(width: 12),
								Expanded(
									child: ElevatedButton(
										onPressed: () {},
										child: const Text('Like'),
									),
								),
							],
						),
					],
				),
			),
		);
	}
}