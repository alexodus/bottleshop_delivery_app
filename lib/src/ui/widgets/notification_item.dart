import 'package:bottleshopdeliveryapp/src/models/shop_notification.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final ShopNotification notification;
  final ValueChanged<ShopNotification> onDismissed;

  const NotificationItem({
    Key key,
    @required this.notification,
    @required this.onDismissed,
  })  : assert(notification != null),
        assert(onDismissed != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.hashCode.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) => onDismissed(notification),
      child: Container(
        color: notification.read
            ? Colors.transparent
            : Theme.of(context).focusColor.withOpacity(0.15),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                    image: AssetImage(notification.image), fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    notification.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyText2.merge(
                          TextStyle(
                            fontWeight: notification.read
                                ? FontWeight.w300
                                : FontWeight.w600,
                          ),
                        ),
                  ),
                  Text(
                    notification.time,
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
