import 'package:bottleshopdeliveryapp/src/models/brand.dart';
import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/services/mock_database_service.dart';
import 'package:bottleshopdeliveryapp/src/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class FilterWidget extends StatefulWidget {
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<Category> _categoriesList = MockDatabaseService().categories;
  List<SubCategory> _subCategoriesList = MockDatabaseService().subCategories;
  List<Brand> _brandsList = MockDatabaseService().brands;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Refine Results'),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        clearSelection();
                      });
                    },
                    child: Text(
                      'Clear',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                primary: true,
                shrinkWrap: true,
                children: <Widget>[
                  ExpansionTile(
                    title: Text('Categories'),
                    children: List.generate(5, (index) {
                      var _category = _categoriesList.elementAt(index);
                      return ExpansionTile(
                        leading: Icon(_category.icon),
                        title: Text(_category.name),
                        children: List.generate(5, (index) {
                          var _subCategory =
                              _subCategoriesList.elementAt(index);
                          return CheckboxListTile(
                            value: _subCategory.selected,
                            onChanged: (value) {
                              setState(() {
                                _subCategory.selected = value;
                              });
                            },
                            title: Text(
                              _subCategory.name,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 1,
                            ),
                          );
                        }),
                      );
                    }),
                    initiallyExpanded: true,
                  ),
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: Text('Brands'),
                    children: List.generate(_brandsList.length, (index) {
                      var _brand = _brandsList.elementAt(index);
                      return CheckboxListTile(
                        value: _brand.selected,
                        onChanged: (value) {
                          setState(() {
                            _brand.selected = value;
                          });
                        },
                        secondary: SizedBox(
                          width: 40,
                          height: 30,
                          child: SvgPicture.asset(
                            _brand.logo,
                            color: _brand.color,
                          ),
                        ),
                        title: Text(
                          _brand.name,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  RoutePaths.categoryDetail,
                  arguments: RouteArgument(
                    id: 2,
                    argumentsList: [
                      _categoriesList.elementAt(0),
                    ],
                  ),
                );
              },
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              color: Theme.of(context).accentColor,
              shape: StadiumBorder(),
              child: Text(
                'Apply Filters',
                textAlign: TextAlign.start,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  void clearSelection() {
    //TODO
  }
}
