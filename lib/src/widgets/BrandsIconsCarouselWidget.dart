import 'package:bottleshopdeliveryapp/src/models/brand.dart';
import 'package:bottleshopdeliveryapp/src/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'BrandIconWidget.dart';

class BrandsIconsCarouselWidget extends StatefulWidget {
  final List<Brand> brandsList;
  final String heroTag;
  final ValueChanged<String> onChanged;

  BrandsIconsCarouselWidget(
      {Key key, this.brandsList, this.heroTag, this.onChanged})
      : super(key: key);

  @override
  _BrandsIconsCarouselWidgetState createState() =>
      _BrandsIconsCarouselWidgetState();
}

class _BrandsIconsCarouselWidgetState extends State<BrandsIconsCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withOpacity(1),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(60),
                      topRight: Radius.circular(60)),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.brandsList.length,
                  itemBuilder: (context, index) {
                    double _marginLeft = 0;
                    (index == 0) ? _marginLeft = 12 : _marginLeft = 0;
                    return BrandIconWidget(
                        heroTag: widget.heroTag,
                        marginLeft: _marginLeft,
                        brand: widget.brandsList.elementAt(index),
                        onPressed: (id) {
                          setState(() {
                            widget.brandsList.forEach((brand) {
                              brand.selected = false;
                              if (brand.id == id) {
                                brand.selected = true;
                              }
                            });
                            widget.onChanged(id);
                          });
                        });
                  },
                  scrollDirection: Axis.horizontal,
                )),
          ),
          Container(
            width: 80,
            margin: EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  topLeft: Radius.circular(60)),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RoutePaths.brands);
              },
              icon: FaIcon(
                FontAwesomeIcons.cog,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
