import 'package:bottleshopdeliveryapp/src/core/data/models/layout.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/viewmodels/home_page_view_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:hooks_riverpod/all.dart';

final sliderTabState = StateNotifierProvider((ref) => TabSliderState());

class TabSliderState extends StateNotifier<int> {
  TabSliderState() : super(0);

  int get currentSlider => state;

  void setCurrentSlider(int index) {
    state = index;
  }
}

final homePageModelProvider =
    ChangeNotifierProvider((ref) => HomePageViewModel());
final layoutModeProvider = StateProvider<LayoutMode>((ref) => LayoutMode.list);
final productRepoInitProvider = FutureProvider<bool>((ref) async {
  final repo = ref.watch(productRepositoryProvider);
  await repo.init();
  return repo.initialized;
});
