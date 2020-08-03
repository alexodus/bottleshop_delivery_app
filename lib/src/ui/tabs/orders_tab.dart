import 'package:bottleshopdeliveryapp/src/models/order.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/orders_products.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class OrdersTab extends StatefulWidget {
  static const String routeName = '/ordersTab';
  final int currentTab;
  OrdersTab({Key key, this.currentTab}) : super(key: key);
  @override
  _OrdersTabState createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final List<Order> _orderList = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.currentTab ?? 0,
      length: 5,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBar(
                showFilter: false,
              ),
            ),
            bottom: TabBar(
              indicatorPadding: EdgeInsets.all(20),
              labelPadding: EdgeInsets.symmetric(horizontal: 5),
              unselectedLabelColor: Theme.of(context).accentColor,
              labelColor: Theme.of(context).primaryColor,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
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
              ],
            ),
          ),
          body: TabBarView(children: [
            OrdersProducts(ordersList: _orderList),
            OrdersProducts(
                ordersList: _orderList.where((order) => order.orderState == OrderState.toBeShipped).toList()),
            OrdersProducts(ordersList: _orderList.where((order) => order.orderState == OrderState.shipped).toList()),
            OrdersProducts(ordersList: _orderList.where((order) => order.orderState == OrderState.delivered).toList()),
            OrdersProducts(ordersList: _orderList.where((order) => order.orderState == OrderState.inDispute).toList()),
          ]),
        ),
      ),
    );
  }
}
