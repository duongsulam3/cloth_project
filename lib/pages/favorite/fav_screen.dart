import 'package:flutter/material.dart';

import 'fav_page_body.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FavPageBody(),
    );
  }
}
