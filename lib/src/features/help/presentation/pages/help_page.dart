import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/app_scaffold.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/search_bar.dart';
import 'package:bottleshopdeliveryapp/src/features/cart/presentation/widgets/shopping_cart_button.dart';
import 'package:bottleshopdeliveryapp/src/features/help/presentation/widgets/faq_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HelpPage extends HookWidget {
  static const routeName = '/help';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: AppScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
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
            ShoppingCartButton(
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
                  SearchBar(showFilter: false),
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
                      return FaqItem(index: index);
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
