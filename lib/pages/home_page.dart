import 'package:flutter/material.dart';
import 'package:food_app/pages/profile_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';


import '../utils/colors.dart';
import 'cart_history.dart';
import 'cart_page.dart';
import 'home/main_page.dart';

/// HomePage displays the main layout with bottom tab navigation
/// using the updated PersistentTabView (clean and non-deprecated).
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Controller to handle tab switching
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  /// Define all the pages for each tab
  List<Widget> _buildScreens() {
    return [
      MainPage(),                    // Home Page
      CartHistory(),                // Order History
      CartPage(),                   // Cart Page
      ProfilePage()
    ];
  }

  /// Define navigation bar items
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history),
        title: "History",
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart),
        title: "Cart",
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,

      /// Controller handles tab switching
      controller: _controller,

      /// The list of screens to display per tab
      screens: _buildScreens(),

      /// Navigation bar items
      items: _navBarsItems(),

      /// Safe area + layout behavior
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,


      /// If true, state of all screens is preserved
      stateManagement: true,

      /// Add border radius or background behind navbar
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10),
        colorBehindNavBar: Colors.white,
      ),



      /// Choose a nav bar style from built-in styles
      navBarStyle: NavBarStyle.style6, // You can use style1, style9 etc.
    );
  }
}
