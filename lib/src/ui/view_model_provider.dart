import 'package:bottleshopdeliveryapp/src/core/viewmodels/base_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewModelProvider<T extends BaseViewModel> extends StatelessWidget {
  final BaseViewModel model;
  final Widget Function(T model) builder;

  ViewModelProvider({@required this.builder, @required this.model});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context2) => model,
      child: Consumer<T>(
        builder: (context, value, child) => builder(value),
      ),
    );
  }
}
