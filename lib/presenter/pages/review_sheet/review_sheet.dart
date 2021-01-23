import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/domain/entities/customer_review.dart';
import 'package:restaurant_app/widgets/menu_tile.dart';

class ReviewSheet extends StatelessWidget {
  final List<CustomerReview> reviews;

  ReviewSheet(this.reviews);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: scaffoldColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: reviews
                  .map((review) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: secondaryColor,
                          foregroundColor: scaffoldColor,
                          child: Text(review.name[0]),
                        ),
                        title: Text(
                          review.review,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .apply(color: primaryColor),
                        ),
                        subtitle: Text(review.name),
                      ))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.close,
                    color: primaryColor,
                  ),
                  onPressed: () => Navigator.pop(context)),
            ],
          )
        ],
      ),
    );
  }
}
