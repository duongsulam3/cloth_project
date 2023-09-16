import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ClothSliderCorousel extends StatelessWidget {
  final String urlImage;
  final int index;
  const ClothSliderCorousel({
    Key? key,
    required this.urlImage,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.maxFinite,
      //margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: CachedNetworkImage(
        imageUrl: urlImage,
        fit: BoxFit.fill,
      ),
    );
  }
}
