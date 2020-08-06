import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/account_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/menu_drawer.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/products_by_category.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/profile_avatar_widget.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/shopping_cart_button.dart';
import 'package:flutter/material.dart';

class CategoryDetailView extends StatefulWidget {
  static const String routeName = '/categoryDetail';
  final RouteArgument routeArgument;
  final Category _category;

  CategoryDetailView({Key key, this.routeArgument})
      : _category = routeArgument.argumentsList[0] as Category;

  @override
  _CategoryDetailViewState createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<SubCategory> _subCategoriesList = [];

  @override
  void initState() {
    _tabController = TabController(
        length: _subCategoriesList.length,
        initialIndex: widget.routeArgument.id,
        vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ignore: always_declare_return_types
  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        widget.routeArgument.id = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuDrawer(),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          snap: true,
          floating: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
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
                  onTap: () {
                    Navigator.pushNamed(context, AccountView.routeName);
                  },
                  child: ProfileAvatar(),
                )),
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
                        tag: widget.routeArgument.id,
                        child: Icon(
                          Icons.category,
                          color: Theme.of(context).primaryColor,
                          size: 70,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget._category.name,
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
            controller: _tabController,
            indicatorWeight: 5,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor:
                Theme.of(context).primaryColor.withOpacity(0.6),
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
            isScrollable: true,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: List.generate(_subCategoriesList.length, (index) {
              return Tab(text: _subCategoriesList.elementAt(index).name);
            }),
          ),
        ),
        SliverToBoxAdapter(
          child: ProductsByCategory(
            subCategory: _subCategoriesList.elementAt(widget.routeArgument.id),
            changeLayout: (newLayoutMode) =>
                debugPrint('Layout changed to ${newLayoutMode.toString()}'),
          ),
        ),
      ]),
    );
  }
}