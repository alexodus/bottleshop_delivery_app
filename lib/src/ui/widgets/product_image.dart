import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final bool isThumbnail;
  final double height;
  final double width;
  final EdgeInsets padding;

  const ProductImage(
      {Key key,
      this.imageUrl,
      this.isThumbnail = true,
      this.width = 160,
      this.height = 160,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return buildPlaceholderProductImage(isThumbnail);
    } else {
      return CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
                width: height,
                height: width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.fitWidth),
                ),
              ),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              buildPlaceholderProductImage(isThumbnail));
    }
  }

  Widget buildPlaceholderProductImage(bool isThumbnail) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
            image: AssetImage(isThumbnail
                ? Constants.defaultProductThumbnail
                : Constants.defaultProductPic),
            fit: BoxFit.fitHeight),
      ),
    );
  }
}
