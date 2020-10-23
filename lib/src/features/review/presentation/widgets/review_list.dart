import 'package:bottleshopdeliveryapp/src/features/review/data/review.dart';
import 'package:bottleshopdeliveryapp/src/features/review/presentation/widgets/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReviewList extends HookWidget {
  final List<Review> reviewsList;

  const ReviewList({
    Key key,
    @required this.reviewsList,
  })  : assert(reviewsList != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) =>
          ReviewItem(review: reviewsList.elementAt(index)),
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
