import 'package:bottleshopdeliveryapp/src/services/database/product_data_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/flash_sales_carousel_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashSalesCarousel extends StatelessWidget {
  final String heroTag;

  final Stream<QuerySnapshot> dataStream;

  const FlashSalesCarousel({
    Key key,
    @required this.heroTag,
    @required this.dataStream,
  })  : assert(heroTag != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        margin: EdgeInsets.only(top: 10),
        child: StreamBuilder(
            stream: dataStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: snapshot?.data?.size ?? 0,
                itemBuilder: (context, index) {
                  var _marginLeft = 0.0;
                  (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                  final product = context
                      .read<ProductDataService>()
                      .parseProductJson(
                          snapshot.data.docs.elementAt(index).data());
                  return FutureBuilder(
                      future: product,
                      initialData: null,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return FlashSalesCarouselItem(
                            heroTag: heroTag,
                            marginLeft: _marginLeft,
                            product: snapshot.data,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      });
                },
                scrollDirection: Axis.horizontal,
              );
            }));
  }
}
