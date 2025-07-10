import 'package:flutter/material.dart';

import 'header_main.dart';
import 'main_food_body.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            //   Header
            MainHeader(),
            Expanded(child: SingleChildScrollView(child: MainFoodBody())),
          ],
        ),
      ),
    );
  }
}
