import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/app/modules/dashboard/dashboard_controller.dart';
import 'package:foodie/app/modules/detailrecepies/detailrecepies_view.dart';
import 'package:foodie/app/modules/myrecipe/myrecipe_view.dart';
import 'package:foodie/app/modules/newrecipe/newrecipe_view.dart';
import 'package:foodie/app/modules/profile/profile_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_core/firebase_core.dart';

class DashboardView extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 290,
              decoration: BoxDecoration(
                color: Color(0xff469110),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  SizedBox(height: 60),
                  Text(
                    "Hi, Embun",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Ignite Your Passion for \nCooking and Whip Up \nTasty Dishes!",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  
                  ),
                  
                  
                ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/bowl.png',
                      height: 160,
                      width: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 23,
                    right: 23,
                    bottom: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffEDEDED),
                        borderRadius: BorderRadius.circular(26.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width:14 ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategory("All"),
                _buildCategory("Rice Dishes"),
                _buildCategory("Sweets"),
                _buildCategory("Snacks"),
                _buildCategory("Drinks"),
                _buildCategory("Chicken & Duck"),
                _buildCategory("Fast Food"),
                _buildCategory("Bread"),
              ].map((category) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: category,
                  )).toList(),
            ),
          ),
                ],
              ),
            ),

            SizedBox(height: 20),
             Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: StreamBuilder(
                stream: controller.getRecipes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong!'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No recipes found'));
                  }

                  var products = snapshot.data!.docs;

                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.55,
                    children: products.map<Widget>((product) {
                      var data = product.data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(4, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: data['image'] != null
                                    ? Image.memory(
                                        base64Decode(data['image']),
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        height: 200,
                                        color: Colors.grey,
                                        child: const Icon(Icons.image, color: Colors.white),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.88,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time, size: 17, color: Color(0xFF00623B)), 
                                        SizedBox(width: 5), 
                                        Text(
                                          data['price'],
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF00623B),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17,
                                          ),
                                        ),
                                        SizedBox(width: 5), 
                                        Text(
                                          ' min',
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF00623B),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09), // Adjust opacity as needed
              spreadRadius: 8, // Adjust spread radius as needed
              blurRadius: 8, // Adjust blur radius as needed
              offset: const Offset(0, -3), // Move shadow upwards (negative y value)
            ),
          ],
        ),
      
        child: ClipRRect(
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  ),
  child: BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    currentIndex: _selectedIndex,
    onTap: (index) {
      _onItemTapped(index);
      switch (index) {
        case 0: Navigator.push(context, MaterialPageRoute(builder: (_) => DashboardView())); break;
        case 1: Navigator.push(context, MaterialPageRoute(builder: (_) => MyrecipeView())); break;
        case 2: Navigator.push(context, MaterialPageRoute(builder: (_) => NewRecipeView())); break;
        case 3: Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileView())); break;
      }
    },
    items: [
      _buildNavItem(Iconsax.home_15, 0),
      _buildNavItem(Iconsax.document_text, 1),
      _buildNavItem(Iconsax.edit, 2),
      _buildNavItem(Iconsax.user, 3),
    ],
  ),
),

      ),
    );
  }
  BottomNavigationBarItem _buildNavItem(IconData icon, int index) {
  return BottomNavigationBarItem(
    label: "",
    icon: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _selectedIndex == index ? Color(0xff469110) : Colors.transparent, 
        borderRadius: BorderRadius.circular(10), 
      ),
      child: Icon(icon, color: _selectedIndex == index ? Colors.white : Colors.grey), 
    ),
  );
}
  Widget _buildCategory(String category) {
    return Obx(() => GestureDetector(
          onTap: () {
            controller.setCategory(category);
            Get.forceAppUpdate(); 
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: controller.selectedCategory.value == category
                  ? const Color(0xFF00623B)
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: controller.selectedCategory.value == category
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ));
  }
  Widget _buildIcon(IconData icon, int index) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _selectedIndex == index ? Color(0xff469110) : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(icon, color: _selectedIndex == index ? Colors.white : Colors.grey),
  );
}
void _onItemTapped(int index) {
  _selectedIndex = index;
}
}
