import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/favorites_tab.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/orders_tab.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/products_tab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum TabItem { favorites, products, orders }

class TabItemData {
  const TabItemData(
      {@required this.key, @required this.title, @required this.icon});

  final String key;
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.favorites: TabItemData(
      key: FavoritesTab.tabKey,
      title: 'Favorites',
      icon: Icons.favorite_border,
    ),
    TabItem.products: TabItemData(
      key: ProductsTab.tabKey,
      title: 'Home',
      icon: Icons.home,
    ),
    TabItem.orders: TabItemData(
      key: OrdersTab.tabKey,
      title: 'Orders',
      icon: Icons.subscriptions,
    ),
  };
}
