import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/app_scaffold.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/product_details_tab.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/product_home_tab.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/product_image.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/review_list.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProductDetailView extends HookWidget {
  static const String routeName = '/productDetail';

  const ProductDetailView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticker = useSingleTickerProvider();
    final tabController =
        useTabController(initialLength: 2, initialIndex: 0, vsync: ticker);
    final RouteArgument args = ModalRoute.of(context).settings.arguments;
    final productId = args.id;
    return AppScaffold(
      scaffoldKey: GlobalKey<ScaffoldState>(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.15),
              blurRadius: 5,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                onPressed: () => {},
                padding: EdgeInsets.symmetric(vertical: 14),
                color: Theme.of(context).accentColor,
                shape: StadiumBorder(),
                // ignore: dead_code
                child: Icon(true ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(width: 10),
            FlatButton(
              onPressed: () {},
              color: Theme.of(context).accentColor,
              shape: StadiumBorder(),
              child: Container(
                width: 240,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Add to Cart',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    IconButton(
                      onPressed:
                          null, //!vm.isProductInCart(productId) ? null : () => {},
                      iconSize: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      icon: Icon(Icons.remove_circle_outline),
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      '',
                      style: Theme.of(context).textTheme.subtitle1.merge(
                            TextStyle(color: Theme.of(context).primaryColor),
                          ),
                    ),
                    IconButton(
                      onPressed: () => {},
                      iconSize: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      icon: Icon(Icons.add_circle_outline),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
//          snap: true,
            floating: true,
//          pinned: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              ShoppingCartButton(
                  iconColor: Theme.of(context).hintColor,
                  labelColor: Theme.of(context).accentColor),
            ],
            backgroundColor: Theme.of(context).primaryColor,
            expandedHeight: 350,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Hero(
                tag: args.argumentsList[1] + productId,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ProductImage(
                      imageUrl: args.argumentsList[0].imageUrl,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      isThumbnail: false,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).primaryColor,
                            Colors.white.withOpacity(0),
                            Colors.white.withOpacity(0),
                            Theme.of(context).scaffoldBackgroundColor
                          ],
                          stops: [0, 0.4, 0.6, 1],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.symmetric(horizontal: 10),
                unselectedLabelColor: Theme.of(context).accentColor,
                labelColor: Theme.of(context).primaryColor,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).accentColor),
                tabs: [
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.2),
                            width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Product'),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Theme.of(context).accentColor.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Review'),
                      ),
                    ),
                  ),
                ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Offstage(
                offstage: 0 != tabController.index,
                child: Column(
                  children: <Widget>[
                    ProductHomeTab(
                      product: args.argumentsList[0],
                    ),
                  ],
                ),
              ),
              Offstage(
                offstage: 1 != tabController.index,
                child: Column(
                  children: <Widget>[
                    ProductDetailsTab(
                      product: args.argumentsList[0],
                    )
                  ],
                ),
              ),
              Offstage(
                offstage: 2 != tabController.index,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          Icons.comment,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'Product Reviews',
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                    ReviewList(
                      reviewsList: [],
                    )
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
