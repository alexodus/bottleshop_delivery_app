import 'package:bottleshopdeliveryapp/src/core/data/models/layout.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/search_bar.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/widgets/favorite_list_item.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/category_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/all.dart';

class ProductsByCategory extends HookWidget {
  final CategoryModel subCategory;
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
          child: SearchBar(
            showFilter: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              Icons.check_box_outline_blank,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              '${subCategory.categoryDetails.name} Category',
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
                        ? Theme.of(context).accentColor
                        : Theme.of(context).focusColor,
                  ),
                ),
                IconButton(
                  onPressed: () => changeLayout(LayoutMode.grid),
                  icon: Icon(
                    Icons.apps,
                    color: layout == LayoutMode.grid
                        ? Theme.of(context).accentColor
                        : Theme.of(context).focusColor,
                  ),
                )
              ],
            ),
          ),
        ),
        Offstage(
          offstage: layout != LayoutMode.list,
          child: categorizedProducts.when(
            data: (data) {
              return ListView.separated(
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
                  );
                },
              );
            },
            loading: null,
            error: null,
          ),
        ),
        Offstage(
          offstage: true, //layout != 'grid',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: StaggeredGridView.countBuilder(
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 4,
              itemCount: 1,
              //subCategory.products.length,
              itemBuilder: (context, index) {
                /*Product product = subCategory.products.elementAt(index);
                return ProductGridItem(
                  product: product,
                  heroTag: 'products_by_category_grid',
                );*/
                return null;
              },
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
            ),
          ),
        ),
      ],
    );
  }
}
