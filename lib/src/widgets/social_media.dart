import 'package:flutter/material.dart';

class SocialMediaWidget extends StatelessWidget {
  final Function signInCallback;

  const SocialMediaWidget({
    Key key,
    @required this.signInCallback,
  })  : assert(signInCallback != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 45,
          height: 45,
          child: InkWell(
            onTap: () => signInCallback('fb'),
            child: Image.asset('assets/images/facebook.png'),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 45,
          height: 45,
          child: InkWell(
            onTap: () => signInCallback('google'),
            child: Image.asset('assets/images/google_logo.png'),
          ),
        ),
      ],
    );
  }
}
