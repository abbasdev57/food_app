import 'package:flutter/material.dart';

import 'header_main.dart';
import 'main_food_body.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        //backgroundColor: Color(0xff8A74741F),
        //appBar: AppBar(),
        body: Column(
          children: [
            // Header Container like Appbar
            MainHeader(),

            //Main Slider
            Expanded(child: SingleChildScrollView(child: MainBody())),
          ],
        ),
      ),
    );
  }
}
