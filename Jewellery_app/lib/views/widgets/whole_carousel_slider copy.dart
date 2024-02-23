import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:Tiara_by_TJ/constants/strings.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';

class SearchProductWholeCarouselSlider extends StatefulWidget {
  final List<ProductImage> listOfProductImage;
  const SearchProductWholeCarouselSlider(
      {super.key, required this.listOfProductImage});

  @override
  State<SearchProductWholeCarouselSlider> createState() =>
      _WholeCarouselSliderState();
}

class _WholeCarouselSliderState
    extends State<SearchProductWholeCarouselSlider> {
  CarouselController carouselController = CarouselController();
  late List<ProductImage> listOfProductImage;

  List<String> urlList = [Strings.defaultImageUrl, Strings.defaultImageUrl];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfProductImage = widget.listOfProductImage;
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        carouselController: carouselController,
        items: listOfProductImage.isEmpty
            ? urlList
                .map(
                  (image) => Image.network(
                    image,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const SizedBox(
                        width: 46.0,
                        height: 16.0,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                )
                .toList()
            : listOfProductImage
                .map(
                  (image) => Image.network(
                    image.src!,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const SizedBox(
                        width: 46.0,
                        height: 16.0,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                )
                .toList(),
        options: CarouselOptions(
            viewportFraction: 1.04,
            height: MediaQuery.of(context).size.height / 2,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayInterval: const Duration(seconds: 10),
            onPageChanged: (index, reason) {
              if (mounted) {
                setState(() {
                  currentIndex = index;
                });
              }
            }),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DotsIndicator(
            dotsCount: listOfProductImage.isEmpty
                ? urlList.length
                : listOfProductImage.length,
            position: currentIndex,
            onTap: (index) {
              carouselController.animateToPage(index);
            },
            decorator: const DotsDecorator(
              color: Colors.grey,
              activeColor: Colors.black,
              size: Size.square(12.0),
              activeSize: Size.square(15.0),
            ),
          )),
    ]);
  }
}
