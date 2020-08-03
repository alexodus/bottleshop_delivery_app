import 'package:bottleshopdeliveryapp/src/models/shop_notification.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/empty_notification.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/notification_item.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class NotificationsTab extends StatefulWidget {
  static const String routeName = '/notifications';
  @override
  _NotificationsTabState createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  List<ShopNotification> _notificationList = [];

  @override
  void initState() {
    //this._notificationList = MockDatabaseService().shopNotifications;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBar(
                showFilter: false,
              ),
            ),
            Offstage(
              offstage: _notificationList.isEmpty,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15),
                shrinkWrap: true,
                primary: false,
                itemCount: _notificationList.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 7);
                },
                itemBuilder: (context, index) {
                  return NotificationItem(
                    notification: _notificationList.elementAt(index),
                    onDismissed: (notification) {
                      setState(() {
                        _notificationList.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            Offstage(
              offstage: _notificationList.isNotEmpty,
              child: EmptyNotification(),
            )
          ],
        ),
      ),
    );
  }
}
