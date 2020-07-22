import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/category_detail_view.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/tabs_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FilterDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = context.select((TabsViewModel viewModel) => viewModel.allCategories);
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
                      return ExpansionTile(
                        leading: FaIcon(FontAwesomeIcons.wineBottle),
                        title: Text(categories.elementAt(index).name),
                        children: List.generate(categories.elementAt(index).subCategories.length, (index) {
                          var subCategory = categories.elementAt(index).subCategories.elementAt(index);
                          return CheckboxListTile(
                            value: context.read<TabsViewModel>().isCategorySelected(subCategory.documentID),
                            onChanged: (bool value) =>
                                context.read<TabsViewModel>().selectSubCategory(subCategory.documentID),
                            title: Text(
                              subCategory.name,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 1,
                            ),
                          );
                        }),
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            FlatButton(
              onPressed: () {
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
            onPressed: () => context.read<TabsViewModel>().clearSelectedCategories(),
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
