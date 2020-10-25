import 'package:bottleshopdeliveryapp/src/core/data/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/pages/category_detail_page.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final categories = useProvider(productRepositoryProvider
        .select((value) => value.selectableCategories));
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            buildDrawerHeader(context),
            Expanded(
              child: ListView(
                primary: true,
                shrinkWrap: true,
                children: <Widget>[
                  ExpansionTile(
                    title: Text('Categories'),
                    initiallyExpanded: true,
                    children: List.generate(categories.length, (index) {
                      var categoryItem = categories.elementAt(index);
                      return categoryItem.subCategories.isNotEmpty
                          ? ExpansionTile(
                              leading: ImageIcon(AssetImage(categoryItem.icon)),
                              title: Text(categoryItem.name),
                              children: categoryItem.subCategories.isNotEmpty
                                  ? List.generate(
                                      categoryItem.subCategories.length ?? 0,
                                      (subIndex) {
                                      final subCategory =
                                          categoryItem.subCategories[subIndex];
                                      return CheckboxListTile(
                                        value: subCategory.selected,
                                        onChanged: (bool shouldSelect) =>
                                            subCategory.selected = shouldSelect,
                                        title: Text(
                                          subCategory.name,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      );
                                    })
                                  : const <Widget>[],
                            )
                          : CheckboxListTile(
                              value: categoryItem.selected,
                              onChanged: (bool shouldSelect) =>
                                  categoryItem.selected = shouldSelect,
                              title: Text(
                                categoryItem.name,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                maxLines: 1,
                              ),
                            );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            FlatButton(
              onPressed: categories.isEmpty
                  ? null
                  : () {
                      Navigator.pushNamed(context, CategoryDetailPage.routeName,
                          arguments: RouteArgument(
                              id: 0, argumentsList: [categories[0]]));
                    },
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              color: Theme.of(context).accentColor,
              shape: StadiumBorder(),
              child: Text(
                'Apply Filters',
                textAlign: TextAlign.start,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  Padding buildDrawerHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Refine Results'),
          MaterialButton(
            onPressed: () =>
                context.read(productRepositoryProvider).clearSelection(),
            child: Text(
              'Clear',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}
