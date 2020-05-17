import 'package:bottleshopdeliveryapp/src/core/models/product.dart';
import 'package:bottleshopdeliveryapp/src/core/services/database/mock_database_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/EmptyFavoritesWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/FavoriteListItemWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/ProductGridItemWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavoritesTab extends StatefulWidget {
  static const String routeName = '/favorites';
  @override
  _FavoritesTabState createState() => _FavoritesTabState();

  FavoritesTab({Key key}) : super(key: key);
}

class _FavoritesTabState extends State<FavoritesTab> {
  String layout = 'grid';
  List<Product> _favoriteList;

  @override
  void initState() {
    _favoriteList = MockDatabaseService().favorites;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(),
          ),
          SizedBox(height: 10),
          Offstage(
            offstage: _favoriteList.isEmpty,
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
                      onPressed: () {
                        setState(() {
                          this.layout = 'list';
                        });
                      },
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: this.layout == 'list'
                            ? Theme.of(context).accentColor
                            : Theme.of(context).focusColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          this.layout = 'grid';
                        });
                      },
                      icon: Icon(
                        Icons.apps,
                        color: this.layout == 'grid'
                            ? Theme.of(context).accentColor
                            : Theme.of(context).focusColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Offstage(
            offstage: this.layout != 'list' || _favoriteList.isEmpty,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: _favoriteList.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return FavoriteListItemWidget(
                  heroTag: 'favorites_list',
                  product: _favoriteList.elementAt(index),
                  onDismissed: () {
                    setState(() {
                      _favoriteList.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
          Offstage(
            offstage: this.layout != 'grid' || _favoriteList.isEmpty,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: StaggeredGridView.countBuilder(
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 4,
                itemCount: _favoriteList.length,
                itemBuilder: (context, index) {
                  Product product = _favoriteList.elementAt(index);
                  return ProductGridItemWidget(
                    product: product,
                    heroTag: 'favorites_grid',
                  );
                },
//                  staggeredTileBuilder: (int index) =>  StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
              ),
            ),
          ),
          Offstage(
            offstage: _favoriteList.isNotEmpty,
            child: EmptyFavoritesWidget(),
          )
        ],
      ),
    );
  }
}
