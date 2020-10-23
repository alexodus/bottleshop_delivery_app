import 'package:bottleshopdeliveryapp/src/core/presentation/res/app_config.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/providers/providers.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class HomeSlider extends HookWidget {
  const HomeSlider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabSlides = useProvider(sliderTabState);
    final sliderList = useProvider(homeSliderProvider);
    return sliderList.when(
      data: (value) => Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              height: 240,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) =>
                  context.read(sliderTabState).setCurrentSlider(index),
            ),
            items: value.map((slide) {
              return Builder(
                builder: (context) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(slide.imageUrl),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 4),
                          blurRadius: 9,
                        ),
                      ],
                    ),
                    child: Container(
                      alignment: AlignmentDirectional.bottomEnd,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: AppConfig(context).appWidth(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              slide.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .merge(TextStyle(
                                      height: 0.8, color: Colors.white)),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.fade,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            bottom: 25,
            right: 41,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: value.map((slide) {
                return Container(
                  width: 20.0,
                  height: 3.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: tabSlides.currentSlider == value.indexOf(slide)
                        ? Theme.of(context).hintColor
                        : Theme.of(context).hintColor.withOpacity(0.3),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 200),
            CircularProgressIndicator(strokeWidth: 2),
          ],
        ),
      ),
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 200),
            Text('Slides failed $err'),
          ],
        ),
      ),
    );
  }
}
