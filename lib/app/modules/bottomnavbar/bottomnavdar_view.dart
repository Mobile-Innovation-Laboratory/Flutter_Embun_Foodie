import 'package:flutter/material.dart';
import 'package:foodie/app/modules/dashboard/dashboard_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:foodie/app/modules/bottomnavbar/bottomnavbar_controller.dart';
import 'package:foodie/app/modules/myrecipe/myrecipe_view.dart';
import 'package:foodie/app/modules/newrecipe/newrecipe_view.dart';
import 'package:foodie/app/modules/profile/profile_view.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavigationController controller = Get.put(BottomNavigationController());

  final List<Widget> pages = [
    DashboardView(), // Dashboard utama
    MyrecipeView(),
    NewRecipeView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() => IndexedStack(
                index: controller.selectedIndex.value,
                children: pages,
              )),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Obx(
            () => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Color(0xFF00623B),
              unselectedItemColor: Colors.grey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.selectedIndex.value,
              onTap: controller.changePage,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.home_15),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.document_text),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.edit),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.user),
                  label: "",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
