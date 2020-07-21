import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/language_item.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/menu_drawer.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/profile_avatar_widget.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/search_bar.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class LanguagesView extends StatelessWidget {
  static const String routeName = '/languages';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LanguagesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Languages',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: <Widget>[
          ShoppingCartButton(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
          Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(300),
                onTap: () {
                  Navigator.pushNamed(context, TabsView.routeName, arguments: Routes.onTabSelection(TabIndex.account));
                },
                child: ProfileAvatar(),
              )),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: StickyHeader(
          header: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBar(showFilter: true),
          ),
          content: Column(
            children: <Widget>[
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  leading: Icon(
                    Icons.translate,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text(
                    'App Language',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: Constants.languages.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return LanguageItem(language: Constants.languages.elementAt(index));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
