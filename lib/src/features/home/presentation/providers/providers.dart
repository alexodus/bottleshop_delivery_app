import 'package:bottleshopdeliveryapp/src/core/data/models/layout.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/viewmodels/home_page_view_model.dart';
import 'package:hooks_riverpod/all.dart';

final sliderTabState = StateNotifierProvider((ref) => TabSliderState());

class TabSliderState extends StateNotifier<int> {
  int _currentSlider = 0;

  TabSliderState() : super(0);

  int get currentSlider => _currentSlider;

  void setCurrentSlider(int index) {
    _currentSlider = index;
  }
}

final homePageModelProvider =
    ChangeNotifierProvider((ref) => HomePageViewModel());
final layoutModeProvider = StateProvider<LayoutMode>((ref) => LayoutMode.list);
