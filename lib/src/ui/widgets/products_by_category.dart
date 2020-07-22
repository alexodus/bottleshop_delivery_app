import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/models/layout.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductsByCategory extends StatelessWidget {
  final Category subCategory;
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
            leading: FaIcon(
              FontAwesomeIcons.box,
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
                    color: layout == LayoutMode.list ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                  ),
                ),
                IconButton(
                  onPressed: () => changeLayout(LayoutMode.grid),
                  icon: Icon(
                    Icons.apps,
                    color: layout == LayoutMode.grid ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                  ),
                )
              ],
            ),
          ),
        ),
        Offstage(
          offstage: layout != LayoutMode.list,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: 5, // TODO: get total items of products per subCategory..products.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              // TODO replace with products list item
              /*return FavoriteListItem(
                heroTag: 'products_by_category_list',
                product: Product('1', '11111', 'dd'),
                onDismissed: ()subCategory.products.removeAt(index),
              );*/
            },
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
              itemCount: 1, //subCategory.products.length,
              itemBuilder: (context, index) {
                /*Product product = subCategory.products.elementAt(index);
                return ProductGridItem(
                  product: product,
                  heroTag: 'products_by_category_grid',
                );*/
              },
              staggeredTileBuilder: (int index) => StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
            ),
          ),
        ),
      ],
    );
  }
}
