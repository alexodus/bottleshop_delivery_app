import 'package:bottleshopdeliveryapp/src/core/presentation/res/app_config.dart';
import 'package:bottleshopdeliveryapp/src/features/home/data/models/tab_item.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

class EmptyFavorites extends StatelessWidget {
  const EmptyFavorites({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: AppConfig(context).appHeight(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Theme.of(context).focusColor,
                          Theme.of(context).accentColor,
                        ])),
                child: Icon(
                  Icons.favorite_border,
                  color: Theme.of(context).primaryColor,
                  size: 70,
                ),
              ),
              Positioned(
                right: -30,
                bottom: -50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                top: -50,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Opacity(
            opacity: 0.8,
            child: Text(
              'Don\'t have any item in the wish list',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3.merge(
                    TextStyle(fontWeight: FontWeight.w300),
                  ),
            ),
          ),
          SizedBox(height: 50),
          FlatButton(
            onPressed: () =>
                context.read(homePageModelProvider).select(TabItem.products),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
            color: Theme.of(context).focusColor.withOpacity(0.55),
            shape: StadiumBorder(),
            child: Text(
              'Start Exploring',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
