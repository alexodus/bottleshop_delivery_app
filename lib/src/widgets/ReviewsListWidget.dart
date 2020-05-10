import 'package:bottleshopdeliveryapp/src/models/review.dart';
import 'package:bottleshopdeliveryapp/src/services/mock_database_service.dart';
import 'package:flutter/material.dart';

import 'ReviewItemWidget.dart';

class ReviewsListWidget extends StatelessWidget {
  final List<Review> _reviewsList = MockDatabaseService().reviewsList;

  ReviewsListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        return ReviewItemWidget(review: _reviewsList.elementAt(index));
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 30,
        );
      },
      itemCount: _reviewsList.length,
      primary: false,
      shrinkWrap: true,
    );
  }
}
