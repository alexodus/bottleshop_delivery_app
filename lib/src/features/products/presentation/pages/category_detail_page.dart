import 'package:bottleshopdeliveryapp/src/core/data/models/layout.dart';
import 'package:bottleshopdeliveryapp/src/core/data/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/providers/core_providers.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/menu_drawer.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/profile_avatar.dart';
import 'package:bottleshopdeliveryapp/src/features/account/presentation/pages/account_page.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/cart/presentation/widgets/shopping_cart_button.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/category_plain_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/widgets/products_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class CategoryDetailPage extends HookWidget {
  static const String routeName = '/categoryDetail';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CategoryDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _logger = useProvider(loggerProvider('CategoryDetailPage'));
    final RouteArgument args =
        ModalRoute.of(context).settings.arguments as RouteArgument;
    _logger.v(
        'passed ARGUMENTS: ${args.title} - ${args.id} - ${args.argumentsList}');
    final category = args.argumentsList[0] as SelectableCategory;
    final index = args.id;
    final tabController = useTabController(
        initialLength: category.subCategories.length, initialIndex: args.id);
    final imageUrl =
        useProvider(currentUserProvider.select((value) => value.avatar));
    final layoutModeState = useState(LayoutMode.list);
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              ShoppingCartButton(
                  iconColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).hintColor),
              Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(300),
                  onTap: () =>
                      Navigator.pushNamed(context, AccountPage.routeName),
                  child: ProfileAvatar(imageUrl: imageUrl),
                ),
              ),
            ],
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
            expandedHeight: 250,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
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
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.10),
                              offset: Offset(0, 4),
                              blurRadius: 10)
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Theme.of(context).accentColor,
                              Theme.of(context).focusColor,
                            ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: index,
                          child: ImageIcon(
                            AssetImage(category.icon),
                            color: Theme.of(context).primaryColor,
                            size: 70,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'test',
                          style: Theme.of(context).textTheme.headline6.merge(
                              TextStyle(color: Theme.of(context).primaryColor)),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: -60,
                    bottom: -100,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(300),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    top: -80,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.09),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottom: TabBar(
              controller: tabController,
              indicatorWeight: 5,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor:
                  Theme.of(context).primaryColor.withOpacity(0.6),
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
              isScrollable: true,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: List.generate(category.subCategories.length, (index) {
                return Tab(text: category.subCategories.elementAt(index).name);
              }),
            ),
          ),
          SliverToBoxAdapter(
            child: ProductsByCategory(
              layout: layoutModeState.value,
              subCategory: category?.subCategories?.isEmpty ?? true
                  ? SelectableSubCategory(id: category.id, name: category.name)
                  : category.subCategories.elementAt(index),
              changeLayout: (layout) => layoutModeState.value == LayoutMode.list
                  ? layoutModeState.value = LayoutMode.grid
                  : layoutModeState.value = LayoutMode.list,
            ),
          ),
        ],
      ),
    );
  }
}
