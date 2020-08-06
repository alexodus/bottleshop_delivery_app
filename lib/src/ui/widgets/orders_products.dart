import 'package:bottleshopdeliveryapp/src/models/order.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/order_grid_item.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/order_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OrdersProducts extends StatefulWidget {
  final List<Order> ordersList;
  @override
  _OrdersProductsState createState() => _OrdersProductsState();

  OrdersProducts({
    Key key,
    @required this.ordersList,
  })  : assert(ordersList != null),
        super(key: key);
}

class _OrdersProductsState extends State<OrdersProducts> {
  String layout = 'list';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Offstage(
            offstage: widget.ordersList.isEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.subscriptions,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Orders List',
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
                          layout = 'list';
                        });
                      },
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: layout == 'list'
                            ? Theme.of(context).accentColor
                            : Theme.of(context).focusColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          layout = 'grid';
                        });
                      },
                      icon: Icon(
                        Icons.apps,
                        color: layout == 'grid'
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
            offstage: layout != 'list' || widget.ordersList.isEmpty,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: widget.ordersList.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return OrderListItem(
                  heroTag: 'orders_list',
                  order: widget.ordersList.elementAt(index),
                  onDismissed: () {
                    setState(() {
                      widget.ordersList.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
          Offstage(
            offstage: layout != 'grid' || widget.ordersList.isEmpty,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: StaggeredGridView.countBuilder(
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 4,
                itemCount: widget.ordersList.length,
                itemBuilder: (context, index) {
                  var order = widget.ordersList.elementAt(index);
                  return OrderGridItem(
                    order: order,
                    heroTag: 'orders_grid',
                  );
                },
//                  staggeredTileBuilder: (int index) =>  StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
