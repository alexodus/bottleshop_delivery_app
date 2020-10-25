import 'package:bottleshopdeliveryapp/src/core/presentation/providers/core_providers.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/filter_drawer.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/loader_widget.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/menu_drawer.dart';
import 'package:bottleshopdeliveryapp/src/features/cart/presentation/widgets/shopping_cart_button.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/providers/providers.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/widgets/tab_scaffold.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class HomePage extends HookWidget {
  static const String routeName = '/home';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productRepository = useProvider(productRepositoryProvider);
    final logger = useProvider(loggerProvider('HomePage'));
    useEffect(() {
      productRepository.init().then((value) => logger.v('initialized'),
          onError: (err) => logger.e('init failed: $err'));
      return;
    }, [_scaffoldKey]);
    return WillPopScope(
      onWillPop: () async => !await context
          .read(homePageModelProvider)
          .navigator
          .currentState
          .maybePop(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Theme.of(context).hintColor),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            context.read(homePageModelProvider).title,
            style: Theme.of(context).textTheme.headline4,
          ),
          actions: <Widget>[
            ShoppingCartButton(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor,
            ),
          ],
        ),
        drawer: MenuDrawer(),
        endDrawer: FilterDrawer(),
        body: Loader(
          inAsyncCall: context.read(productRepositoryProvider).isLoading,
          child: useProvider(homePageModelProvider
              .select((value) => value.tabBuilder(context))),
        ),
        bottomNavigationBar: TabScaffold(
          onSelectTab: context.read(homePageModelProvider).select,
          selectedIndex:
              useProvider(homePageModelProvider.select((value) => value.index)),
        ),
      ),
    );
  }
}
