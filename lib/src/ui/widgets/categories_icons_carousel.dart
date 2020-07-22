import 'package:bottleshopdeliveryapp/src/ui/views/categories_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/category_Icon.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/home_tab_view_model.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/tabs_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CategoriesIconsCarousel extends StatelessWidget {
  final TickerProvider tickerProvider;
  const CategoriesIconsCarousel({
    Key key,
    @required this.tickerProvider,
  })  : assert(tickerProvider != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = context.select((HomeTabViewModel viewModel) => viewModel.categories);
    return SizedBox(
      height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(1),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(60), topRight: Radius.circular(60)),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CategoriesView.routeName);
              },
              icon: FaIcon(
                FontAwesomeIcons.cog,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 0),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withOpacity(1),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60), topLeft: Radius.circular(60)),
                ),
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    double _marginLeft = 0;
                    (index == 0) ? _marginLeft = 12 : _marginLeft = 0;
                    return CategoryIcon(
                        tickerProvider: tickerProvider,
                        heroTag: 'home_categories_1',
                        marginLeft: _marginLeft,
                        category: categories.elementAt(index),
                        onPressed: (id) => context.read<TabsViewModel>().selectCategory(id));
                  },
                  scrollDirection: Axis.horizontal,
                )),
          ),
        ],
      ),
    );
  }
}
