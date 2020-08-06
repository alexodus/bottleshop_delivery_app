import 'package:bottleshopdeliveryapp/src/ui/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget endDrawer;
  final AppBar appBar;
  final Widget body;
  final BottomNavigationBar bottomNavigationBar;

  const AppScaffold(
      {Key key,
      @required this.scaffoldKey,
      @required this.body,
      this.appBar,
      this.endDrawer,
      this.bottomNavigationBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      key: scaffoldKey,
      endDrawer: endDrawer,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
