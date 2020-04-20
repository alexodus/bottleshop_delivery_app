import 'package:bottleshopdeliveryapp/models/user.dart';
import 'package:bottleshopdeliveryapp/screens/authenticate/authenticate.dart';
import 'package:bottleshopdeliveryapp/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
