import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/pages/home/url_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cloth_slider.dart';

class SliderImagesAndDotsWidget extends StatefulWidget {
  const SliderImagesAndDotsWidget({Key? key}) : super(key: key);

  @override
  State<SliderImagesAndDotsWidget> createState() =>
      _SliderImagesAndDotsWidgetState();
}

class _SliderImagesAndDotsWidgetState extends State<SliderImagesAndDotsWidget> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: urlBannerImages.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = urlBannerImages[index];
            return ClothSliderCorousel(
              urlImage: urlImage,
              index: index,
            );
          },
          options: CarouselOptions(
            height: Dimensions.height250,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) => setState(
              () => activeIndex = index,
            ),
            //enlargeCenterPage: true,
          ),
        ),
        SizedBox(height: Dimensions.height10),
        buildDots(),
      ],
    );
  }

  Widget buildDots() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlBannerImages.length,
        effect: CustomizableEffect(
          dotDecoration: DotDecoration(
            width: Dimensions.width10,
            height: Dimensions.height5,
            color: Colors.grey,
            dotBorder: const DotBorder(
              padding: 1,
              width: 1,
              color: Colors.grey,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(1),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(1),
            ),
            verticalOffset: 0,
          ),
          spacing: 6.0,
          activeDotDecoration: DotDecoration(
            width: Dimensions.width15,
            height: Dimensions.height5,
            color: const Color(0xffEFC76F),
            rotationAngle: 180,
            verticalOffset: -5,
            borderRadius: BorderRadius.circular(24),
            dotBorder: const DotBorder(
              padding: 1,
              width: 1,
              color: Colors.indigo,
            ),
          ),
        ),
      );
}
