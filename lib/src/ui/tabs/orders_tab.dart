import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/models/order_model.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/empty_orders_products.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/orders_products.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/search_bar.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/tabs_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderList = <OrderModel>[];
    return orderList.isEmpty
        ? EmptyOrdersProducts()
        : DefaultTabController(
            initialIndex: context
                    .select((TabsViewModel viewModel) =>
                        viewModel.initialOrderTabIndex)
                    .index ??
                0,
            length: OrderTabIndex.values.length,
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
                                  color: Theme.of(context).accentColor,
                                  width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('All'),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Theme.of(context).accentColor,
                                  width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('To be shipped'),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Theme.of(context).accentColor,
                                  width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Shipped'),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Theme.of(context).accentColor,
                                  width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('In Dispute'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(children: [
                  OrdersProducts(ordersList: orderList),
                  OrdersProducts(
                      ordersList: orderList
                          .where((order) =>
                              order.statusStepId == OrderStatus.ordered.index)
                          .toList()),
                  OrdersProducts(
                      ordersList: orderList
                          .where((order) =>
                              order.statusStepId == OrderStatus.ready.index)
                          .toList()),
                  OrdersProducts(
                      ordersList: orderList
                          .where((order) =>
                              order.statusStepId == OrderStatus.shipped.index)
                          .toList()),
                ]),
              ),
            ),
          );
  }
}
