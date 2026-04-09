import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../screens/homeScreen.dart';
import '../screens/menuScreen.dart';
import '../screens/moreScreen.dart';
import '../screens/offerScreen.dart';
import '../screens/profileScreen.dart';
import '../utils/helper.dart';

class CustomNavBar extends StatelessWidget {
  final bool home;
  final bool menu;
  final bool offer;
  final bool profile;
  final bool more;

  const CustomNavBar({
    this.home = false,
    this.menu = false,
    this.offer = false,
    this.profile = false,
    this.more = false,
  });

  Widget buildNavItem(
      {required bool isActive,
      required String activeIcon,
      required String inactiveIcon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Helper.getAssetName(
                isActive ? activeIcon : inactiveIcon, "virtual"),
          ),
          Text(
            label,
            style: TextStyle(color: isActive ? AppColor.orange : Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: Helper.getScreenWidth(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              width: Helper.getScreenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildNavItem(
                    isActive: menu,
                    activeIcon: "more_filled.png",
                    inactiveIcon: "more.png",
                    label: "Menu",
                    onTap: () {
                      if (!menu) {
                        Navigator.of(context)
                            .pushReplacementNamed(MenuScreen.routeName);
                      }
                    },
                  ),
                  buildNavItem(
                    isActive: offer,
                    activeIcon: "bag_filled.png",
                    inactiveIcon: "bag.png",
                    label: "Offers",
                    onTap: () {
                      if (!offer) {
                        Navigator.of(context)
                            .pushReplacementNamed(OfferScreen.routeName);
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  buildNavItem(
                    isActive: profile,
                    activeIcon: "user_filled.png",
                    inactiveIcon: "user.png",
                    label: "Profile",
                    onTap: () {
                      if (!profile) {
                        Navigator.of(context)
                            .pushReplacementNamed(ProfileScreen.routeName);
                      }
                    },
                  ),
                  buildNavItem(
                    isActive: more,
                    activeIcon: "menu_filled.png",
                    inactiveIcon: "menu.png",
                    label: "More",
                    onTap: () {
                      if (!more) {
                        Navigator.of(context)
                            .pushReplacementNamed(MoreScreen.routeName);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: home ? AppColor.orange : AppColor.placeholder,
                onPressed: () {
                  if (!home) {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  }
                },
                child: Image.asset(
                    Helper.getAssetName("home_white.png", "virtual")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(
      size.width * 0.375,
      0,
      size.width * 0.375,
      size.height * 0.1,
    );
    path.cubicTo(
      size.width * 0.4,
      size.height * 0.9,
      size.width * 0.6,
      size.height * 0.9,
      size.width * 0.625,
      size.height * 0.1,
    );
    path.quadraticBezierTo(
      size.width * 0.625,
      0,
      size.width * 0.7,
      0,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
