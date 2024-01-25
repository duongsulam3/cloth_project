import 'package:flutter/material.dart';
import 'package:intern_project/controller/clothing_controller.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/pages/home/build_grid_products.dart';
import 'package:intern_project/pages/home/sale_banner.dart';
import 'package:intern_project/pages/home/slider_images_and_dots_widget.dart';
import 'package:intern_project/pages/home/title_text_and_icon.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height20),
              Padding(
                padding: EdgeInsets.all(Dimensions.height5),
                child: const SaleBanner(),
              ),
              SizedBox(height: Dimensions.height20),
              SliderImagesAndDotsWidget(banners: readBanner()),
              SizedBox(height: Dimensions.height20),
              const TitleTextAndIcon(
                text: "Suggest for you",
                icon: Icon(Icons.arrow_right_rounded),
              ),
              BuildGridProducts(products: readAllCloth()),
            ],
          ),
        ),
      ),
    );
  }
}
