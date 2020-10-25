import 'package:bottleshopdeliveryapp/src/core/data/models/layout.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/providers/core_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/widgets/favorite_list_item.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/category_plain_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/widgets/product_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/all.dart';

class ProductsByCategory extends HookWidget {
  final SelectableSubCategory subCategory;
  final LayoutMode layout;
  final ValueChanged<LayoutMode> changeLayout;

  const ProductsByCategory({
    Key key,
    @required this.subCategory,
    @required this.changeLayout,
    this.layout = LayoutMode.list,
  })  : assert(subCategory != null),
        assert(changeLayout != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final categorizedProducts = useProvider(otherProductsProvider);
    return Wrap(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              Icons.category,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              '${subCategory.name} Category',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: Theme.of(context).textTheme.headline4,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  onPressed: () => changeLayout(LayoutMode.list),
                  icon: Icon(
                    Icons.format_list_bulleted,
                    color: layout == LayoutMode.list
                        ? Theme.of(context).focusColor
                        : Theme.of(context).accentColor,
                  ),
                ),
                IconButton(
                  onPressed: () => changeLayout(LayoutMode.grid),
                  icon: Icon(
                    Icons.apps,
                    color: layout == LayoutMode.grid
                        ? Theme.of(context).focusColor
                        : Theme.of(context).accentColor,
                  ),
                )
              ],
            ),
          ),
        ),
        categorizedProducts.when(
          data: (data) {
            return layout != LayoutMode.list
                ? ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: data.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      return FavoriteListItem(
                        heroTag: 'products_by_category_list',
                        product: data.elementAt(index),
                        onDismissed: () =>
                            useProvider(loggerProvider('ProductsByCategory')),
                      );
                    },
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: StaggeredGridView.countBuilder(
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ProductGridItem(
                          product: data.elementAt(index),
                          heroTag: 'products_by_category_grid',
                        );
                      },
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                    ),
                  );
          },
          loading: () => CircularProgressIndicator(),
          error: (_, __) => Text('Error'),
        ),
      ],
    );
  }
}
