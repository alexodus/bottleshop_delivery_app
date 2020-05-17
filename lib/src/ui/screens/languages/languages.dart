import 'package:bottleshopdeliveryapp/src/core/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/core/enums/enums.dart';
import 'package:bottleshopdeliveryapp/src/core/models/language_model.dart';
import 'package:bottleshopdeliveryapp/src/core/services/database/mock_database_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/tabs/tabs_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/DrawerWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/LanguageItemWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/SearchBarWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/ShoppingCartButtonWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/profile_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class LanguagesScreen extends StatefulWidget {
  static const String routeName = '/languages';
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<LanguageModel> _languagesList;
  @override
  void initState() {
    _languagesList = MockDatabaseService().languages;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
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
          ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
          Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(300),
                onTap: () {
                  Navigator.pushNamed(context, TabsScreen.routeName,
                      arguments: Routes.onTabSelection(TabIndex.account));
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
            child: SearchBarWidget(),
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
                itemCount: _languagesList.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return LanguageItemWidget(
                      language: _languagesList.elementAt(index));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
