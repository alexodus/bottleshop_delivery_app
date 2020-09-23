import 'package:bottleshopdeliveryapp/src/models/slider_model.dart';
import 'package:bottleshopdeliveryapp/src/repositories/product_repository.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';

final slidersDataProvider = FutureProvider<List<SliderModel>>((_) async {
  final data = await ProductRepository().getSlidersConfig();
  return [...data];
});

final homeTabState = StateNotifierProvider((ref) => HomeTabSliderState());

class HomeTabSliderState extends StateNotifier<int> {
  int _currentSlider = 0;

  HomeTabSliderState() : super(0);
  int get currentSlider => _currentSlider;

  void setCurrentSlider(int index) {
    _currentSlider = index;
  }
}
