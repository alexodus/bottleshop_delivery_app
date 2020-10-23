import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget endDrawer;
  final AppBar appBar;
  final Widget body;
  final Widget bottomNavigationBar;

  const AppScaffold(
      {Key key,
      this.scaffoldKey,
      @required this.body,
      this.appBar,
      this.endDrawer,
      this.bottomNavigationBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: MenuDrawer(),
      endDrawer: endDrawer,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
