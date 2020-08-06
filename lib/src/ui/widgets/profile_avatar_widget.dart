import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = context.select((User value) => value?.avatar);
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => CircleAvatar(
          backgroundImage: AssetImage(Constants.defaultAvatar),
        ),
      );
    }
    return CircleAvatar(
      backgroundImage: AssetImage(Constants.defaultAvatar),
    );
  }
}
