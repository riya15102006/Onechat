import 'package:flutter/material.dart';

class ProfileSetupScreen extends StatefulWidget {
	const ProfileSetupScreen({super.key});

	static const String routePath = '/setup';
	static const String routeName = 'profileSetup';

	@override
	State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
	final TextEditingController _name = TextEditingController();
	final TextEditingController _age = TextEditingController();
	final TextEditingController _bio = TextEditingController();
	String _gender = 'Other';
	String _mood = '🙂';

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Setup Profile')),
			body: SingleChildScrollView(
				padding: const EdgeInsets.all(16),
				child: Column(
					children: [
						TextField(controller: _name, decoration: const InputDecoration(labelText: 'Name')),
						const SizedBox(height: 12),
						TextField(
							controller: _age,
							decoration: const InputDecoration(labelText: 'Age'),
							keyboardType: TextInputType.number,
						),
						const SizedBox(height: 12),
						DropdownButtonFormField<String>(
							value: _gender,
							items: const [
								DropdownMenuItem(value: 'Male', child: Text('Male')),
								DropdownMenuItem(value: 'Female', child: Text('Female')),
								DropdownMenuItem(value: 'Other', child: Text('Other')),
							],
							onChanged: (v) => setState(() => _gender = v ?? 'Other'),
							decoration: const InputDecoration(labelText: 'Gender'),
						),
						const SizedBox(height: 12),
						TextField(
							controller: _bio,
							maxLines: 3,
							decoration: const InputDecoration(labelText: 'Short bio'),
						),
						const SizedBox(height: 12),
						DropdownButtonFormField<String>(
							value: _mood,
							items: const [
								DropdownMenuItem(value: '🙂', child: Text('🙂 Chill')),
								DropdownMenuItem(value: '🤗', child: Text('🤗 Social')),
								DropdownMenuItem(value: '🤔', child: Text('🤔 Thoughtful')),
								DropdownMenuItem(value: '🔥', child: Text('🔥 Hype')),
							],
							onChanged: (v) => setState(() => _mood = v ?? '🙂'),
							decoration: const InputDecoration(labelText: 'Mood'),
						),
						const SizedBox(height: 16),
						ElevatedButton(onPressed: () {}, child: const Text('Save')),
					],
				),
			),
		);
	}
}