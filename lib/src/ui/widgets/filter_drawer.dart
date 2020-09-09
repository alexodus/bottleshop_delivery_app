import 'package:bottleshopdeliveryapp/src/models/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/category_detail_view.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/category_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories =
        context.select<CategoryListModel, List<CategoriesTreeModel>>(
            (vm) => vm.categories);
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
                              leading: Icon(Icons.category),
                              title: Text(categoryItem.categoryDetails.name),
                              children: categoryItem.subCategories.isNotEmpty
                                  ? List.generate(
                                      categoryItem.subCategories.length ?? 0,
                                      (subIndex) {
                                      final subCategory =
                                          categoryItem.subCategories[subIndex];
                                      return CheckboxListTile(
                                        value: context
                                            .watch<CategoryListModel>()
                                            .isSubCategorySelected(subCategory
                                                .categoryDetails.name),
                                        onChanged: (bool shouldSelect) {
                                          context
                                              .read<CategoryListModel>()
                                              .toggleSubCategorySelection(
                                                  subCategory
                                                      .categoryDetails.name);
                                        },
                                        title: Text(
                                          subCategory.categoryDetails.name,
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
                                  .watch<CategoryListModel>()
                                  .isCategorySelected(
                                      categoryItem.categoryDetails.name),
                              onChanged: (bool shouldSelect) {
                                context
                                    .read<CategoryListModel>()
                                    .toggleSubCategorySelection(
                                        categoryItem.categoryDetails.name);
                              },
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
              onPressed: categories.isEmpty
                  ? null
                  : () {
                      Navigator.pushNamed(
                        context,
                        CategoryDetailView.routeName,
                        arguments: RouteArgument(
                          id: 2,
                          argumentsList: [
                            categories.elementAt(0),
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
                context.read<CategoryListModel>().clearAllSelection(),
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
