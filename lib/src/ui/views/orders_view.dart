import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/models/order.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/menu_drawer.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/orders_products.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/profile_avatar_widget.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/shopping_cart_button.dart';
import 'package:flutter/material.dart';

class OrdersView extends StatefulWidget {
  static const String routeName = '/orders';
  final int currentTab;
  OrdersView({Key key, this.currentTab}) : super(key: key);
  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Order> _orderList = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: widget.currentTab ?? 0,
        length: 5,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: MenuDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.sort, color: Theme.of(context).hintColor),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'My Orders',
              style: Theme.of(context).textTheme.headline4,
            ),
            actions: <Widget>[
              ShoppingCartButton(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
              Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(300),
                    onTap: () {
                      Navigator.pushNamed(context, TabsView.routeName,
                          arguments: Routes.onTabSelection(TabIndex.account));
                    },
                    child: const ProfileAvatar(),
                  )),
            ],
            bottom: TabBar(
                indicatorPadding: EdgeInsets.all(10),
                labelPadding: EdgeInsets.symmetric(horizontal: 5),
                unselectedLabelColor: Theme.of(context).accentColor,
                labelColor: Theme.of(context).primaryColor,
                isScrollable: true,
                indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Theme.of(context).accentColor),
                tabs: [
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("All"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Unpaid"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Shipped"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("To be shipped"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("In Dispute"),
                      ),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(children: [
            OrdersProducts(ordersList: _orderList),
            OrdersProducts(ordersList: _orderList.where((order) => order.orderState == OrderState.delivered).toList()),
            OrdersProducts(ordersList: _orderList.where((order) => order.orderState == OrderState.shipped).toList()),
            OrdersProducts(
                ordersList: _orderList.where((order) => order.orderState == OrderState.toBeShipped).toList()),
            OrdersProducts(ordersList: _orderList.where((order) => order.orderState == OrderState.inDispute).toList()),
          ]),
        ));
  }
}
