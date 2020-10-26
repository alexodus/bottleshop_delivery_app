import 'package:bottleshopdeliveryapp/src/features/home/data/models/tab_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TabScaffold extends StatelessWidget {
  final ValueChanged<TabItem> onSelectTab;
  final int selectedIndex;
  const TabScaffold({
    Key key,
    @required this.onSelectTab,
    @required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: const Key('tabBar'),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).accentColor,
      unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
      selectedIconTheme: IconThemeData(size: 35),
      unselectedIconTheme: IconThemeData(size: 25),
      selectedFontSize: 15,
      unselectedFontSize: 10,
      iconSize: 22,
      elevation: 0,
      backgroundColor: Colors.transparent,
      onTap: (index) => onSelectTab(TabItem.values[index]),
      items: List.generate(
        TabItemData.allTabs.length,
        (index) => _buildItem(TabItemData.allTabs.keys.elementAt(index)),
      ),
      currentIndex: selectedIndex,
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(itemData.icon),
      label: itemData.title,
    );
  }
}
