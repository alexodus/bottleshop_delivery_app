import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SocialMediaWidget extends StatelessWidget {
  final VoidCallback signInWithFacebook;
  final VoidCallback signInWithGoogle;
  final VoidCallback signInAnonymously;
  final VoidCallback signInWithApple;

  const SocialMediaWidget({
    Key key,
    @required this.signInWithFacebook,
    @required this.signInWithGoogle,
    @required this.signInWithApple,
    @required this.signInAnonymously,
  })  : assert(signInWithFacebook != null),
        assert(signInWithGoogle != null),
        assert(signInWithApple != null),
        assert(signInAnonymously != null),
        super(key: key);

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
        SizedBox(width: 10),
        SizedBox(
          width: 45,
          height: 45,
          child: InkWell(
            onTap: signInWithApple,
            child: Image.asset('assets/images/apple_login.png'),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 45,
          height: 45,
          child: InkWell(
            onTap: signInAnonymously,
            child: Image.asset('assets/images/anonymous.png'),
          ),
        ),
      ],
    );
  }
}
