import 'package:bottleshopdeliveryapp/src/ui/widgets/app_scaffold.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/language_item.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/languages_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguagesView extends StatelessWidget {
  static const String routeName = '/languages';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LanguagesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LanguagesViewModel(context.read),
      builder: (context, child) {
        return AppScaffold(
          scaffoldKey: _scaffoldKey,
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
          body: SingleChildScrollView(
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
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount:
                      context.watch<LanguagesViewModel>().languages.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return LanguageItem(
                        language: context
                            .watch<LanguagesViewModel>()
                            .languages
                            .elementAt(index));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
