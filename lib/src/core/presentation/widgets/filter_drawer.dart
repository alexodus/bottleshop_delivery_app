import 'package:bottleshopdeliveryapp/src/core/data/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/pages/category_detail_page.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final categories = useProvider(categoriesProvider);
    return Drawer(
      child: SafeArea(
        child: categories.when(
          data: (data) => Column(
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
                      children: List.generate(data.length, (index) {
                        var categoryItem = data.elementAt(index);
                        final state = useState<bool>(false);
                        return categoryItem.subCategories.isNotEmpty
                            ? ExpansionTile(
                                leading: Icon(Icons.category),
                                title: Text(categoryItem.categoryDetails.name),
                                children: categoryItem.subCategories.isNotEmpty
                                    ? List.generate(
                                        categoryItem.subCategories.length ?? 0,
                                        (subIndex) {
                                        final subCategory = categoryItem
                                            .subCategories[subIndex];
                                        final state = useState(false);
                                        return CheckboxListTile(
                                          value: state.value,
                                          onChanged: (bool shouldSelect) =>
                                              state.value = shouldSelect,
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
                                value: state.value,
                                onChanged: (bool shouldSelect) {
                                  state.value = shouldSelect;
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
                onPressed: data.isEmpty
                    ? null
                    : () {
                        Navigator.pushNamed(
                          context,
                          CategoryDetailPage.routeName,
                          arguments: RouteArgument(
                            id: 2,
                            argumentsList: [
                              data.elementAt(0),
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
          loading: () => Column(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
          error: (_, __) => Text(
            'No categories found',
          ),
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
                context.read(categoryFilterProvider).clearSelection(),
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
