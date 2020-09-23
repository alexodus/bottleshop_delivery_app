import 'package:bottleshopdeliveryapp/src/models/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/repositories/product_repository.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/category_detail_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/app_scaffold.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/menu_drawer.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/search_bar.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

class CategoriesView extends StatelessWidget {
  static const String routeName = '/categories';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldKey: _scaffoldKey,
      endDrawer: MenuDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Categories',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: <Widget>[
          ShoppingCartButton(
            iconColor: Theme.of(context).hintColor,
            labelColor: Theme.of(context).accentColor,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Wrap(
          runSpacing: 20,
          children: <Widget>[
            SearchBar(
              showFilter: true,
            ),
            useProvider(categoriesProvider).when(
              data: (categories) => Wrap(
                runSpacing: 30,
                children: List.generate(categories.length, (index) {
                  if (index.isEven) {
                    return buildEvenCategory(
                        context, categories.elementAt(index));
                  }
                  return buildOddCategory(context, categories.elementAt(index));
                }),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: null,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildEvenCategory(BuildContext context, CategoriesTreeModel category) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        width: 120,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.10),
                        offset: Offset(0, 4),
                        blurRadius: 10)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Theme.of(context).accentColor,
                        Theme.of(context).accentColor.withOpacity(0.2),
                      ])),
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: category.categoryDetails.id,
                    child: Icon(
                      Icons.category,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    category.categoryDetails.name,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            Positioned(
              right: -40,
              bottom: -60,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
            ),
            Positioned(
              left: -30,
              top: -60,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
            )
          ],
        ),
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.10),
                  offset: Offset(0, 4),
                  blurRadius: 10)
            ],
          ),
          constraints: BoxConstraints(minHeight: 120),
          child: Wrap(
            runAlignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 5,
            children: category.subCategories != null
                ? List.generate(category.subCategories.length, (index) {
                    var subCategory = category.subCategories.elementAt(index);
                    return Material(
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, CategoryDetailView.routeName,
                              arguments: RouteArgument(
                                  id: index, argumentsList: [category]));
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.2)),
                          ),
                          child: Text(
                            subCategory.categoryDetails.name,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                    );
                  })
                : const <Widget>[],
          ),
        ),
      )
    ],
  );
}

Widget buildOddCategory(BuildContext context, CategoriesTreeModel category) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.10),
                  offset: Offset(0, 4),
                  blurRadius: 10)
            ],
          ),
          constraints: BoxConstraints(minHeight: 120),
          child: Wrap(
            runAlignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 5,
            children: category.subCategories != null
                ? List.generate(category.subCategories.length, (index) {
                    var subCategory = category.subCategories.elementAt(index);
                    return Material(
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, CategoryDetailView.routeName,
                              arguments: RouteArgument(
                                  id: index, argumentsList: [category]));
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.2)),
                          ),
                          child: Text(
                            subCategory.categoryDetails.name,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                    );
                  })
                : const <Widget>[],
          ),
        ),
      ),
      SizedBox(
        width: 120,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.10),
                        offset: Offset(0, 4),
                        blurRadius: 10)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Theme.of(context).accentColor,
                        Theme.of(context).accentColor.withOpacity(0.2),
                      ])),
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: category.categoryDetails.id,
                    child: Icon(
                      Icons.category,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    category.categoryDetails.name,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            Positioned(
              right: -40,
              bottom: -60,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
            ),
            Positioned(
              left: -30,
              top: -60,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
}
