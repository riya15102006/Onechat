import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
	const SettingsScreen({super.key});

	static const String routePath = '/settings';
	static const String routeName = 'settings';

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Settings')),
			body: ListView(
				children: const [
					SwitchListTile(value: true, onChanged: null, title: Text('Dark Mode')),
					ListTile(title: Text('Privacy')), 
					ListTile(title: Text('Block / Report')),
				],
			),
		);
	}
}