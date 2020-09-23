import 'package:bottleshopdeliveryapp/src/models/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/repositories/product_repository.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/category_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<CategoriesTreeModel>> categories =
        useProvider(categoriesProvider);
    return categories.when(
        loading: null,
        error: null,
        data: (value) {
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
                          children: List.generate(value.length, (index) {
                            var categoryItem = value.elementAt(index);
                            return categoryItem.subCategories.isNotEmpty
                                ? ExpansionTile(
                                    leading: Icon(Icons.category),
                                    title:
                                        Text(categoryItem.categoryDetails.name),
                                    children: categoryItem
                                            .subCategories.isNotEmpty
                                        ? List.generate(
                                            categoryItem.subCategories.length ??
                                                0, (subIndex) {
                                            final subCategory = categoryItem
                                                .subCategories[subIndex];
                                            return CheckboxListTile(
                                              value: context
                                                  .read(categoriesStateProvider)
                                                  .isSelected(subCategory
                                                      .categoryDetails.id),
                                              onChanged: (bool shouldSelect) =>
                                                  context
                                                      .read(
                                                          categoriesStateProvider)
                                                      .selectCategory(
                                                          subCategory
                                                              .categoryDetails
                                                              .id),
                                              title: Text(
                                                subCategory
                                                    .categoryDetails.name,
                                                overflow: TextOverflow.fade,
                                                softWrap: false,
                                                maxLines: 1,
                                              ),
                                            );
                                          })
                                        : const <Widget>[],
                                  )
                                : CheckboxListTile(
                                    value: context
                                        .read(categoriesStateProvider)
                                        .isSelected(
                                            categoryItem.categoryDetails.id),
                                    onChanged: (bool shouldSelect) => context
                                        .read(categoriesStateProvider)
                                        .selectCategory(
                                            categoryItem.categoryDetails.id),
                                    title: Text(
                                      categoryItem.categoryDetails.name,
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
                    onPressed: value.isEmpty
                        ? null
                        : () {
                            Navigator.pushNamed(
                              context,
                              CategoryDetailView.routeName,
                              arguments: RouteArgument(
                                id: 2,
                                argumentsList: [
                                  value.elementAt(0),
                                ],
                              ),
                            );
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
        });
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
                context.read(categoriesStateProvider).clearSelection(),
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
