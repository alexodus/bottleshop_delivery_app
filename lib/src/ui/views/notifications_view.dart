import 'package:bottleshopdeliveryapp/src/ui/widgets/app_scaffold.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/empty_notification.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/notification_item.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  static const String routeName = '/notifications';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    const notificationList = [];
    return AppScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: <Widget>[
            Offstage(
              offstage: notificationList.isEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBar(
                  showFilter: false,
                ),
              ),
            ),
            Offstage(
              offstage: notificationList.isEmpty,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15),
                shrinkWrap: true,
                primary: false,
                itemCount: notificationList.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 7);
                },
                itemBuilder: (context, index) {
                  return NotificationItem(
                    notification: notificationList.elementAt(index),
                    onDismissed: (notification) {},
                  );
                },
              ),
            ),
            Offstage(
              offstage: notificationList.isNotEmpty,
              child: EmptyNotification(),
            )
          ],
        ),
      ),
    );
  }
}
