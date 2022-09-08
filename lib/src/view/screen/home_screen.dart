import 'package:flutter/material.dart';
import 'package:juna_restaurant/src/view/screen/cart_screen.dart';
import 'package:juna_restaurant/src/view/screen/favorite_screen.dart';
import 'package:juna_restaurant/src/view/screen/food_list_screen.dart';
import 'package:juna_restaurant/src/view/screen/profile_screen.dart';
import '../../../core/app_data.dart';
import '../../controller/food_controller.dart';
import 'package:get/get.dart';

import '../widget/page_transition.dart';
import 'last_order.dart';

final FoodController controller = Get.put(FoodController());

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<Widget> screen = [
    const FoodListScreen(),
     CartScreen(),
    const FavoriteScreen(),
    const LastOrder()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => PageTransition(
          child: screen[controller.currentBottomNavItemIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentBottomNavItemIndex.value,
          onTap: controller.switchBetweenBottomNavigationItems,
          selectedFontSize: 0,
          items: AppData.bottomNavigationItems.map(
            (element) {
              return BottomNavigationBarItem(
                  icon: element.disableIcon,
                  label: element.label,
                  activeIcon: element.enableIcon);
            },
          ).toList(),
        );
      }),
    );
  }
}
