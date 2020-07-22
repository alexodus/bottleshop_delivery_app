import 'package:bottleshopdeliveryapp/src/models/layout.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/empty_favorites.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/favorite_list_item.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/product_grid_item.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/search_bar.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/favorites_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FavoritesTab extends StatelessWidget {
  static const String routeName = '/favorites';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesTabViewModel>(
        create: (_) => FavoritesTabViewModel(context.read),
        builder: (context, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchBar(
                    showFilter: true,
                  ),
                ),
                SizedBox(height: 10),
                FavoriteListTile(),
                FavoritesListLayout(),
                FavoritesGridLayout(),
                Offstage(
                  offstage: context.select((FavoritesTabViewModel value) => value.favorites).isNotEmpty,
                  child: EmptyFavorites(),
                )
              ],
            ),
          );
        });
  }
}

class FavoritesGridLayout extends StatelessWidget {
  const FavoritesGridLayout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorites = context.select((FavoritesTabViewModel value) => value.favorites);
    final layoutMode = context.select((FavoritesTabViewModel value) => value.layoutMode);
    return Offstage(
      offstage: layoutMode != LayoutMode.grid || favorites.isEmpty,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: StaggeredGridView.countBuilder(
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 4,
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            Product product = favorites.elementAt(index);
            return ProductGridItem(
              product: product,
              heroTag: 'favorites_grid',
            );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
        ),
      ),
    );
  }
}

class FavoritesListLayout extends StatelessWidget {
  const FavoritesListLayout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorites = context.select((FavoritesTabViewModel value) => value.favorites);
    final layoutMode = context.select((FavoritesTabViewModel value) => value.layoutMode);
    return Offstage(
      offstage: layoutMode != LayoutMode.list || favorites.isEmpty,
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemCount: favorites.length,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            return FavoriteListItem(
              heroTag: 'favorites_list',
              product: favorites.elementAt(index),
              onDismissed: () => context.read<FavoritesTabViewModel>().removeProductFromFavorites(index),
            );
          }),
    );
  }
}

class FavoriteListTile extends StatelessWidget {
  const FavoriteListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorites = context.select((FavoritesTabViewModel value) => value.favorites);
    final layoutMode = context.select((FavoritesTabViewModel value) => value.layoutMode);
    return Offstage(
      offstage: favorites.isEmpty,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          leading: FaIcon(
            FontAwesomeIcons.heart,
            color: Theme.of(context).hintColor,
          ),
          title: Text(
            'Wish List',
            overflow: TextOverflow.fade,
            softWrap: false,
            style: Theme.of(context).textTheme.headline4,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: () => context.read<FavoritesTabViewModel>().setLayoutMode(LayoutMode.list),
                icon: Icon(
                  Icons.format_list_bulleted,
                  color: layoutMode == LayoutMode.list ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                ),
              ),
              IconButton(
                onPressed: () => context.read<FavoritesTabViewModel>().setLayoutMode(LayoutMode.grid),
                icon: Icon(
                  Icons.apps,
                  color: layoutMode == LayoutMode.grid ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
