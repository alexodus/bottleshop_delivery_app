import 'package:bottleshopdeliveryapp/src/widgets/DrawerWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/FaqItemWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/SearchBarWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.sort, color: Theme.of(context).primaryColor),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Products'),
              Tab(text: 'Services'),
              Tab(text: 'Delivery'),
              Tab(text: 'Misc'),
            ],
            labelColor: Theme.of(context).primaryColor,
          ),
          title: Text(
            'Help & Support',
            style: Theme.of(context)
                .textTheme
                .headline4
                .merge(TextStyle(color: Theme.of(context).primaryColor)),
          ),
          actions: <Widget>[
            ShoppingCartButtonWidget(
                iconColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).hintColor),
          ],
        ),
        body: TabBarView(
          children: List.generate(4, (index) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SearchBarWidget(),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    leading: Icon(
                      Icons.help,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      'Faq',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 15);
                    },
                    itemBuilder: (context, index) {
                      return FaqItemWidget(index: index);
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
