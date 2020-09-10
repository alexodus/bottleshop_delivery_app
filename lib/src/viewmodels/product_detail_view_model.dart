import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class ProductDetailViewModel extends BaseViewModel {
  final _logger = Analytics.getLogger('ProductDetailView');

  ProductDetailViewModel(Locator locator) : super(locator: locator);
}
