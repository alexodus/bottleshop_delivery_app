import 'package:bottleshopdeliveryapp/src/models/language.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/app_scaffold.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/language_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

final languageViewState = Provider((_) => [
      Language(
          englishName: 'English',
          localName: 'Angličtina',
          flag: 'assets/images/united-states-of-america.png'),
      Language(
          englishName: 'Slovak',
          flag: 'assets/images/slovakia.png',
          localName: 'Slovenčina')
    ]);

class LanguagesView extends StatelessWidget {
  static const String routeName = '/languages';

  const LanguagesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldKey: GlobalKey<ScaffoldState>(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Languages',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: LanguageScrollView(),
    );
  }
}

class LanguageScrollView extends StatelessWidget {
  const LanguageScrollView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
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
          Consumer(
            builder: (context, watch, child) {
              final items = watch(languageViewState);
              return ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: items.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) =>
                    LanguageItem(language: items.elementAt(index)),
              );
            },
          ),
        ],
      ),
    );
  }
}
