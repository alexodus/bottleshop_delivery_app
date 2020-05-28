import 'package:bottleshopdeliveryapp/src/core/models/order.dart';
import 'package:bottleshopdeliveryapp/src/core/services/database/mock_database_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/orders/orders_products.dart';
import 'package:flutter/material.dart';

class OrdersTab extends StatefulWidget {
  static const String routeName = '/orders-tab';
  final int currentTab;
  OrdersTab({Key key, this.currentTab}) : super(key: key);
  @override
  _OrdersTabState createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final List<Order> _orderList = MockDatabaseService().orders;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: widget.currentTab ?? 0,
        length: 5,
        child: Column(
          children: [
            TabBar(
                indicatorPadding: EdgeInsets.all(10),
                labelPadding: EdgeInsets.symmetric(horizontal: 5),
                unselectedLabelColor: Theme.of(context).accentColor,
                labelColor: Theme.of(context).primaryColor,
                isScrollable: true,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).accentColor),
                tabs: [
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
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
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
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
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
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
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
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
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("In Dispute"),
                      ),
                    ),
                  ),
                ]),
            TabBarView(children: [
              OrdersProductsScreen(ordersList: _orderList),
              OrdersProductsScreen(
                  ordersList: _orderList
                      .where((order) => order.orderState == OrderState.unpaid)
                      .toList()),
              OrdersProductsScreen(
                  ordersList: _orderList
                      .where((order) => order.orderState == OrderState.shipped)
                      .toList()),
              OrdersProductsScreen(
                  ordersList: _orderList
                      .where(
                          (order) => order.orderState == OrderState.toBeShipped)
                      .toList()),
              OrdersProductsScreen(
                  ordersList: _orderList
                      .where(
                          (order) => order.orderState == OrderState.inDispute)
                      .toList()),
            ]),
          ],
        ));
  }
}