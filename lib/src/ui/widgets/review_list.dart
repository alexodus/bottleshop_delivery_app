import 'package:bottleshopdeliveryapp/src/models/review.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/review_item.dart';
import 'package:flutter/material.dart';

class ReviewList extends StatelessWidget {
  final List<Review> reviewsList;

  const ReviewList({
    Key key,
    this.reviewsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) => ReviewItem(review: reviewsList.elementAt(index)),
      separatorBuilder: (context, index) {
        return Divider(
          height: 30,
        );
      },
      itemCount: reviewsList.length,
      primary: false,
      shrinkWrap: true,
    );
  }
}
