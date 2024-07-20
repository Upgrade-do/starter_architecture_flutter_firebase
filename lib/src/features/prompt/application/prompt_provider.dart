import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:riverpod/riverpod.dart';

import 'package:starter_architecture_flutter_firebase/src/features/prompt/data/prompt_view_model.dart';

final promptNotifierProvider =
    StateNotifierProvider<PromptNotifier, PromptState>(
  (ref) {
    final model =
        FirebaseVertexAI.instance.generativeModel(model: 'gemini-1.5-flash');
    return PromptNotifier(
      multiModalModel: model,
      textModel: model,
    );
  },
);
