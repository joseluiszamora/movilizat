import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:movilizat/core/constants/app_colors.dart';
import 'package:movilizat/core/constants/app_images.dart';
import 'package:movilizat/core/layouts/layout_main.dart';
import 'package:movilizat/core/themes/constants.dart';
import 'package:movilizat/views/fuel/fuel_page.dart';
import 'package:movilizat/views/home/home_page.dart';
import 'package:movilizat/views/parking/parking_page.dart';
import 'package:movilizat/views/profile/profile_page.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _pageSelected = 1;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
    const colorOptions = ColorFilter.mode(kPrimaryColor, BlendMode.srcIn);

    //* Pages List
    List<Widget> pages = [
      const HomePage(),
      const FuelPage(),
      const ParkingPage(),
      const ProfilePage()
    ];

    //* Menu Items List
    List<Widget> items = [
      SvgPicture.asset(AppImages.navigationHome,
          colorFilter: colorOptions, width: 35, height: 35),
      SvgPicture.asset(AppImages.navigationFuel,
          colorFilter: colorOptions, width: 35, height: 35),
      SvgPicture.asset(AppImages.navigationParking,
          colorFilter: colorOptions, width: 35, height: 35),
      SvgPicture.asset(AppImages.navigationUser,
          colorFilter: colorOptions, width: 35, height: 35),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: LayoutMain(content: pages[_pageSelected]),
      ),
      bottomNavigationBar: Container(
        color: AppColors.scaffoldBackground,
        child: SafeArea(
          child: CurvedNavigationBar(
            key: bottomNavigationKey,
            index: _pageSelected,
            height: 60.0,
            items: items,
            color: Theme.of(context).navigationBarTheme.backgroundColor!,
            buttonBackgroundColor: AppColors.scaffoldBackground,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            animationCurve: Curves.easeOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _pageSelected = index;
              });
            },
            letIndexChange: (value) => true,
          ),
        ),
      ),
    );
  }
}
