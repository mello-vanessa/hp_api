import 'package:hp_api/src/get_sentences/sentence_repository.dart';

import '../models/characters_model.dart';

class SentenceController {
  final SentenceRepository repository;

  const SentenceController({required this.repository});

  Future<List<Characters>> getSentence() async {
    try {
      final response = await repository.getSentence();
      return response;
    } catch (e) {
      /// crashlytics.logError(e);
      /// updateState(StateError(e));
      rethrow;
    }
  }
}
