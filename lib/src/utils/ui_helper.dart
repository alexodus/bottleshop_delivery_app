import 'dart:io';

import 'package:bottleshopdeliveryapp/src/state/AuthState.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = Provider.of<AuthState>(context)?.user?.avatar;
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
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    }
    return CircleAvatar(
      backgroundImage: AssetImage('assets/images/avatar.png'),
    );
  }
}

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: Platform.isIOS
            ? CupertinoActivityIndicator(radius: 35, animating: true)
            : CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor),
              ),
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }
}
