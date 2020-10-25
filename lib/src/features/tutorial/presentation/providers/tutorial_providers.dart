import 'package:bottleshopdeliveryapp/src/features/tutorial/data/models/tutorial_model.dart';
import 'package:bottleshopdeliveryapp/src/features/tutorial/data/services/db_service.dart';
import 'package:bottleshopdeliveryapp/src/features/tutorial/presentation/viewmodel/tutorial_view_model.dart';
import 'package:hooks_riverpod/all.dart';

final tutorialScreensProvider =
    FutureProvider.autoDispose<List<TutorialModel>>((ref) async {
  final modelStream = tutorialDb.streamList().single;
  final model = await modelStream;
  return model;
});

final localTutorialProvider = Provider(
  (_) => [
    TutorialModel(
      image: 'assets/images/onboarding0.png',
      description: 'Don\'t cry because it\'s over, smile because it happened.',
    ),
    TutorialModel(
      image: 'assets/images/onboarding1.png',
      description: 'Be yourself, everyone else is already taken.',
    ),
  ],
);

final tutorialModelProvider =
    StateNotifierProvider((ref) => IntroViewModel(ref.read));
