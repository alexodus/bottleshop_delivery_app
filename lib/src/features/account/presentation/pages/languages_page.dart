import 'package:bottleshopdeliveryapp/generated/l10n.dart';
import 'package:bottleshopdeliveryapp/src/features/account/presentation/providers/providers.dart';
import 'package:bottleshopdeliveryapp/src/features/account/presentation/widgets/language_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class LanguagesPage extends HookWidget {
  static const String routeName = '/languages';

  LanguagesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languages = useProvider(languagesPageStateProvider);
    return Scaffold(
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
          children: [
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
                  S.of(context).appLanguageLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: languages.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) => LanguageListItem(
                  language: languages.elementAt(index),
                  isSelected: index == 0 ? true : false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
