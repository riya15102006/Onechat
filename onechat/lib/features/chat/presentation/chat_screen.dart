import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../chat/state/chat_controller.dart';

class ChatScreen extends ConsumerStatefulWidget {
	const ChatScreen({super.key, required this.matchId});

	static const String routePath = '/chat';
	static const String routeName = 'chat';

	final String matchId;

	@override
	ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
	final TextEditingController _text = TextEditingController();
	bool isRecording = false;

	@override
	Widget build(BuildContext context) {
		final messagesAsync = ref.watch(chatMessagesProvider(widget.matchId));
		final senderId = FirebaseAuth.instance.currentUser?.uid ?? 'me';
		return Scaffold(
			appBar: AppBar(title: const Text('Chat')),
			body: Column(
				children: [
					Expanded(
						child: messagesAsync.when(
							data: (messages) => ListView.builder(
								padding: const EdgeInsets.all(12),
								itemCount: messages.length,
								itemBuilder: (context, i) {
									final m = messages[i];
									final isMine = m.senderId == senderId;
									return Align(
										alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
										child: Container(
											margin: const EdgeInsets.symmetric(vertical: 6),
											padding: const EdgeInsets.all(12),
											decoration: BoxDecoration(
												color: isMine ? Colors.purple : Colors.grey.shade800,
												borderRadius: BorderRadius.circular(16),
											),
											child: Text(m.text ?? '🎤 Voice', style: const TextStyle(color: Colors.white)),
										),
									);
								},
							),
							error: (e, s) => Center(child: Text('Error: $e')),
							loading: () => const Center(child: CircularProgressIndicator()),
						),
					),
					SafeArea(
						child: Row(
							children: [
								IconButton(
									onPressed: () {
										setState(() => isRecording = !isRecording);
									},
									icon: Icon(isRecording ? Icons.stop_circle : Icons.mic),
								),
								Expanded(
									child: TextField(
										controller: _text,
										decoration: const InputDecoration(hintText: 'Type a message'),
									),
								),
								IconButton(
									onPressed: () async {
										final text = _text.text.trim();
										if (text.isEmpty) return;
										await ref.read(chatControllerProvider).sendText(
											matchId: widget.matchId,
											senderId: senderId,
											text: text,
										);
										_text.clear();
									},
									icon: const Icon(Icons.send),
								),
							],
						),
					),
				],
			),
		);
	}
}