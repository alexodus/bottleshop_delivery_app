import 'package:bottleshopdeliveryapp/src/core/presentation/providers/core_providers.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/res/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

class ProductImage extends StatelessWidget {
  final String imagePath;
  final String thumbnailPath;
  final bool isThumbnail;
  final double height;
  final double width;
  final EdgeInsets padding;

  const ProductImage(
      {Key key,
      this.imagePath,
      this.thumbnailPath,
      this.isThumbnail = true,
      this.width = 160,
      this.height = 160,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePath == null && thumbnailPath == null) {
      return buildPlaceholderProductImage(isThumbnail);
    } else {
      final url = imagePath == null ? thumbnailPath : imagePath;
      return useProvider(downloadUrlProvider(url)).when(
        data: (imageUrl) => CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
                  width: height,
                  height: width,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                buildPlaceholderProductImage(isThumbnail)),
        loading: () => buildPlaceholderProductImage(isThumbnail),
        error: (_, __) => buildPlaceholderProductImage(isThumbnail),
      );
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
              ? AppConstants.defaultProductThumbnail
              : AppConstants.defaultProductPic),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
