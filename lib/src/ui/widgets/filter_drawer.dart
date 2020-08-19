import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/category_detail_view.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/category_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = context
        .select<CategoryListModel, List<Category>>((vm) => vm.categories);
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
                      final category =
                          context.select<CategoryListModel, Category>(
                              (vm) => vm.categories[index]);
                      return ExpansionTile(
                        leading: Icon(Icons.category),
                        title: Text(category.name),
                        children: category.subCategories != null
                            ? List.generate(
                                category?.subCategories?.length ?? 0,
                                (subIndex) {
                                final subCategory =
                                    category?.subCategories[subIndex];
                                return CheckboxListTile(
                                  value: context
                                      .watch<CategoryListModel>()
                                      .isSubCategorySelected(subCategory.name),
                                  onChanged: (bool shouldSelect) {
                                    context
                                        .read<CategoryListModel>()
                                        .toggleSubCategorySelection(
                                            subCategory.name);
                                  },
                                  title: Text(
                                    subCategory.name,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                );
                              })
                            : const <Widget>[],
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
