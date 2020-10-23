import 'package:bottleshopdeliveryapp/src/core/data/models/layout.dart';
import 'package:bottleshopdeliveryapp/src/features/orders/presentation/providers/providers.dart';
import 'package:bottleshopdeliveryapp/src/features/orders/presentation/widgets/order_grid_item.dart';
import 'package:bottleshopdeliveryapp/src/features/orders/presentation/widgets/order_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrdersProductsPage extends HookWidget {
  final orders = useProvider(ordersProvider);
  final layoutState = useState<LayoutMode>(LayoutMode.list);
  @override
  Widget build(BuildContext context) {
    return orders.when(
      data: (data) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Offstage(
                offstage: data.isEmpty,
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
                          onPressed: () => layoutState.value = LayoutMode.list,
                          icon: Icon(
                            Icons.format_list_bulleted,
                            color: layoutState.value == LayoutMode.list
                                ? Theme.of(context).accentColor
                                : Theme.of(context).focusColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () => layoutState.value = LayoutMode.grid,
                          icon: Icon(
                            Icons.apps,
                            color: layoutState.value == LayoutMode.grid
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
                offstage: layoutState.value != LayoutMode.list || data.isEmpty,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: data.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return OrderListItem(
                      heroTag: 'orders_list',
                      order: data.elementAt(index),
                      onDismissed: () {
                        /*setState(() {
                          widget.ordersList.removeAt(index);
                        });*/
                      },
                    );
                  },
                ),
              ),
              Offstage(
                offstage: layoutState.value != LayoutMode.grid || data.isEmpty,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: StaggeredGridView.countBuilder(
                    primary: false,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var order = data.elementAt(index);
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
      },
      loading: () => CircularProgressIndicator(),
      error: (_, __) => Text('Error'),
    );
  }
}
