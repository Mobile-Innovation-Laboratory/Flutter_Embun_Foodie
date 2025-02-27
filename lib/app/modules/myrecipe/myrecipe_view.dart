import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/app/modules/dashboard/dashboard_view.dart';
import 'package:foodie/app/modules/editrecepies/editrecepies_view.dart';
import 'package:foodie/app/modules/newrecipe/newrecipe_view.dart';
import 'package:foodie/app/modules/profile/profile_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';

class MyrecipeView extends StatelessWidget {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    var sessionBox = Hive.box('session');
    var currentUserId = sessionBox.get('userId');
    return Scaffold(
      appBar: AppBar(
        title: Text('My Recipe', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left, size: 33),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('recipes')
              .where('userId', isEqualTo: currentUserId)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No recipes found'));
            }

            var recipes = snapshot.data!.docs;

            return GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.58,
              children: recipes.map((recipe) {
                var item = recipe.data() as Map<String, dynamic>;

                return GestureDetector(
                  onTap: () {
                    Get.to(() => EditRecepiesView(
                          productName: item['name'],
                          productImage: item['image'],
                          productPrice: item['price'],
                          productDescription: item['description'],
                          ingredients: item['ingredients'],
                          howToCook: item['howtocook'],
                          category: item['category'],
                          username: item['userName'],
                        ));
                  },
                  child: Container(
                    width: 160,
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
                          child: Image.network(
                            item['image'],
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.88,
                                ),
                              ),
                              Text(
                                item['price'] ?? '',
                                style: const TextStyle(
                                  color: Color(0xFF00623B),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('recipes')
                                              .doc(recipe.id)
                                              .delete();
                                        },
                                        icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                        constraints: const BoxConstraints(minWidth: 0, minHeight: 30),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Get.to(() => EditRecepiesView(
                                                productName: item['name'],
                                                productImage: item['image'],
                                                productPrice: item['price'],
                                                productDescription: item['description'],
                                                ingredients: item['ingredients'],
                                                howToCook: item['howtocook'],
                                                category: item['category'],
                                                username: item['userName'],
                                              ));
                                        },
                                        icon: const Icon(Icons.edit, color: Color(0xff292D32), size: 20),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              spreadRadius: 8,
              blurRadius: 8,
              offset: const Offset(0, -3),
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
        color: _selectedIndex == index ? Color(0xff469110) : Colors.transparent, // Hijau jika dipilih
        borderRadius: BorderRadius.circular(10), // Biar kotaknya rounded
      ),
      child: Icon(icon, color: _selectedIndex == index ? Colors.white : Colors.grey), // Putih jika dipilih
    ),
  );
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
