import 'package:bottleshopdeliveryapp/src/core/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/core/viewmodels/base_view_model.dart';
import 'package:flutter/cupertino.dart';

class ResetPasswordViewModel extends BaseViewModel {
  ResetPasswordViewModel({BuildContext context}) : super(context: context);

  Future<void> sendResetPasswordEmail(String email) async {
    try {
      loading = true;
      await authentication.sendPasswordResetEmail(email);
    } finally {
      loading = false;
    }
  }

  @override
  void dispose() {
    Analytics.getLogger('ResetPasswordViewModel').d('disposed');
    super.dispose();
  }
}
