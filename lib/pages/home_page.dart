import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../utils/colors.dart';
import 'cart_history.dart';
import 'cart_page.dart';
import 'home/main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // late PersistentTabController _controller;

  final List<Widget> _pages = [
    MainPage(),
    CartPage(),
    CartHistory(),
    Scaffold(body: Center(child: Text("Profile Page"))), //
  ];


  int _selectedIndex = 0;

  List<Widget> _buildScreens() {
    return [
      MainPage(),
      CartPage(),
      CartHistory()
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey[400],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey[400],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.history),
        title: ("History"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey[400],
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = PersistentTabController(initialIndex: 0);
  }

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return PersistentTabView(context, screens: _buildScreens(),
  //     controller: _controller,
  //     items: _navBarsItems(),
  //     confineToSafeArea: true,
  //     backgroundColor: Colors.white,
  //     handleAndroidBackButtonPress: true,
  //     resizeToAvoidBottomInset: true,
  //     stateManagement: true,
  //     // hideNavigationBarWhenKeyboardShows: true,
  //     // popAllScreensOnTapOfSelectedTab: true,
  //     // popActionScreens: PopActionScreensType.all,
  //     // itemAnimationProperties: ItemAnimationProperties(
  //     //   duration: Duration(milliseconds: 200),
  //     //   curve: Curves.ease,
  //     // ),
  //     // screenTransitionAnimation: ScreenTransitionAnimation(
  //     //   animateTabTransition: true,
  //     //   curve: Curves.ease,
  //     //   duration: Duration(milliseconds: 200),
  //     // ),
  //     navBarStyle: NavBarStyle.style1,
  //   );
  // }


 @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey[400],
        selectedItemColor: AppColors.mainColor,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon:Icon(Icons.archive),label: "History" ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
