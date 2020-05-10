import 'package:bottleshopdeliveryapp/src/models/shop_notification.dart';
import 'package:bottleshopdeliveryapp/src/services/mock_database_service.dart';
import 'package:bottleshopdeliveryapp/src/widgets/EmptyNotificationsWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/NotificationItemWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';

class ShopNotificationsScreen extends StatefulWidget {
  @override
  _ShopNotificationsScreenState createState() =>
      _ShopNotificationsScreenState();
}

class _ShopNotificationsScreenState extends State<ShopNotificationsScreen> {
  List<ShopNotification> _notificationList;

  @override
  void initState() {
    this._notificationList = MockDatabaseService().shopNotifications;
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
              child: SearchBarWidget(),
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
                  return NotificationItemWidget(
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
              child: EmptyNotificationsWidget(),
            )
          ],
        ),
      ),
    );
  }
}
