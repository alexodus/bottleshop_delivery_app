import 'package:bottleshopdeliveryapp/src/core/models/user.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/core/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<Authentication>(context, listen: false);
    final userDatabase = Provider.of<Database<User>>(context, listen: false);
    return StreamBuilder<User>(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        final User user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<User>.value(value: user),
              StreamProvider<User>.value(
                value: userDatabase.stream(user.uid),
                catchError: (_, __) => user,
              ),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
