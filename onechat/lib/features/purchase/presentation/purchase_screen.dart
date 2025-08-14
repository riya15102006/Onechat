import 'package:flutter/material.dart';

class PurchaseScreen extends StatelessWidget {
	const PurchaseScreen({super.key});

	static const String routePath = '/purchase';
	static const String routeName = 'purchase';

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Get Credits & Premium')),
			body: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					children: [
						Card(
							child: ListTile(
								title: const Text('One Last Message Credit'),
								subtitle: const Text('Send a final message after chat expires'),
								trailing: ElevatedButton(onPressed: () {}, child: const Text('Buy')),
							),
						),
						const SizedBox(height: 12),
						Card(
							child: ListTile(
								title: const Text('Rewind Last Match'),
								subtitle: const Text('Get a second chance'),
								trailing: ElevatedButton(onPressed: () {}, child: const Text('Buy')),
							),
						),
						const SizedBox(height: 12),
						Card(
							child: ListTile(
								title: const Text('Premium Subscription'),
								subtitle: const Text('Themes, chat skins, streak boosts'),
								trailing: ElevatedButton(onPressed: () {}, child: const Text('Subscribe')),
							),
						),
					],
				),
			),
		);
	}
}