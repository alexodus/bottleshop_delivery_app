import 'package:bottleshopdeliveryapp/src/core/data/services/logger.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/services/user_db_service.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:hooks_riverpod/all.dart';

class IntroViewModel extends StateNotifier<int> {
  final _logger = createLogger('IntroViewModel');
  final Reader read;

  IntroViewModel(this.read) : super(0);

  dynamic pageChanged(int index, CarouselPageChangedReason reason) {
    _logger.d('changing index: $index reason: $reason');
    state = index;
  }

  int get currentIndex => state;

  Future<void> finishIntroScreen() async {
    final uid = read(currentUserProvider).uid;
    await userDb.updateData(uid, {'introSeen': true});
  }
}
