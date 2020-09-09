import 'package:bottleshopdeliveryapp/src/models/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/categories_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/category_icon.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/category_list_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesIconsCarousel extends StatelessWidget {
  final TickerProvider tickerProvider;
  final ValueChanged<String> onChanged;

  const CategoriesIconsCarousel({
    Key key,
    @required this.tickerProvider,
    @required this.onChanged,
  })  : assert(tickerProvider != null),
        assert(onChanged != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final noCategories =
        context.select<CategoryListModel, bool>((vm) => vm.categories.isEmpty);
    return Offstage(
      offstage: noCategories,
      child: SizedBox(
        height: 65,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(1),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    topRight: Radius.circular(60)),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CategoriesView.routeName);
                },
                icon: Icon(
                  Icons.settings,
                  size: 28,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withOpacity(1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      topLeft: Radius.circular(60)),
                ),
                child: ListView.builder(
                  dragStartBehavior: DragStartBehavior.start,
                  itemCount: context.select<CategoryListModel, int>(
                      (value) => value.categories.length),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(parent: ClampingScrollPhysics()),
                  itemBuilder: (context, index) {
                    return Builder(
                      builder: (context) {
                        final category = context.select<CategoryListModel,
                            CategoriesTreeModel>((vm) => vm.categories[index]);
                        return CategoryIcon(
                          tickerProvider: tickerProvider,
                          heroTag: 'home_categories_1',
                          marginLeft: (index == 0) ? 12 : 0,
                          category: category,
                          onPressed: (categoryName) {
                            context
                                .read<CategoryListModel>()
                                .toggleSubCategorySelection(categoryName);
                            onChanged(categoryName);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
