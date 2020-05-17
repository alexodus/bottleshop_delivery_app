import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SocialMediaWidget extends StatelessWidget {
  final Function signInWithFacebook;
  final Function signInWithGoogle;

  const SocialMediaWidget({
    Key key,
    @required this.signInWithFacebook,
    @required this.signInWithGoogle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          width: 45,
          height: 45,
          child: InkWell(
            onTap: signInWithFacebook,
            child: Image.asset('assets/images/facebook.png'),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 45,
          height: 45,
          child: InkWell(
            onTap: signInWithGoogle,
            child: Image.asset('assets/images/google_logo.png'),
          ),
        ),
      ],
    );
  }
}
