import 'package:flutter/material.dart';

import 'header_main.dart';
import 'main_food_body.dart';

/// MainPage is the **home screen** of the app.
/// It contains the header section and the main food body content.
///
/// - The **header** (MainHeader) works like a custom AppBar.
/// - The **main body** (MainBody) contains sliders, product lists, etc.
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      // SafeArea ensures that UI does not overlap system status bar or notch areas
      child: Scaffold(
        // Scaffold provides the basic visual layout structure for the page
        // backgroundColor: Color(0xff8A74741F), // Optional background color for the whole screen

        body: Column(
          // Using Column to place header and content vertically
          children: [
            /// ===== HEADER SECTION =====
            /// This is a custom widget (MainHeader) acting like an AppBar.
            /// It might contain location, search, profile, or other top bar elements.
            MainHeader(),

            /// ===== MAIN CONTENT SECTION =====
            /// The rest of the screen displays scrollable food items, banners, etc.
            /// Wrapped inside Expanded to take up remaining space
            /// and SingleChildScrollView to make it vertically scrollable.
            Expanded(
              child: SingleChildScrollView(
                child: MainBody(), // Contains sliders, product cards, etc.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
