import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/features/chat/application/get_all_messages_provider.dart';
import 'package:starter_architecture_flutter_firebase/src/features/chat/presentation/send_image_screen.dart';
import 'package:starter_architecture_flutter_firebase/src/features/chat/presentation/widgets/messages_list.dart';
import 'package:starter_architecture_flutter_firebase/src/theme/app_theme.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late final TextEditingController _messageController;
  // final Gemini gemini = Gemini.instance;
  FocusNode? textFieldNode;
  // final apiKey = dotenv.env['GOOGLE_API_KEY'] ?? '';
  final apiKey = 'AIzaSyCG1Vl2PQiF4NH4k-Y4tru_ShrvygYHzgo';

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();

    textFieldNode = FocusNode(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            event.physicalKey == PhysicalKeyboardKey.enter) {
          sendMessage();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    textFieldNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return Scaffold(
      backgroundColor: theme.colorsPalette.white,
      appBar: AppBar(
        title: const Text("Gemini Chat"),
        backgroundColor: theme.colorsPalette.white,
        scrolledUnderElevation: 0.0,
        actions: [
          Consumer(builder: (context, ref, child) {
            return IconButton(
              onPressed: () {
                // ref.read(authProvider).singout();
              },
              icon: const Icon(
                Icons.logout,
              ),
            );
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Column(
          children: [
            // Message List
            Expanded(
              child: MessagesList(
                userId: FirebaseAuth.instance.currentUser!.uid,
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: theme.colorsPalette.neutral2,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                children: [
                  // Message Text field
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      focusNode: textFieldNode,
                      onSubmitted: (input) async => sendMessage(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Ask any question',
                      ),
                    ),
                  ),

                  // Image Button
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SendImageScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.image,
                    ),
                  ),

                  // Send Button
                  IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(
                      Icons.send,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;
    await ref.read(chatProvider).sendTextMessage(
          apiKey: apiKey,
          textPrompt: _messageController.text,
        );
    _messageController.clear();
  }
}
