import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/app/modules/dashboard/dashboard_view.dart';
import 'package:foodie/app/modules/myrecipe/myrecipe_view.dart';
import 'package:foodie/app/modules/newrecipe/newrecipe_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  int _selectedIndex=3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 33,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No user data available'));
          }
          var userData = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/Avatar.png'),
                ),
                const SizedBox(height: 30),
                buildProfileInfo("Full Name", userData['fullname'] ?? ""),
                buildProfileInfo("Phone Number", userData['phonenumber'] ?? ""),
                buildProfileInfo("Email", userData['email'] ?? ""),
                const SizedBox(height: 150),
               ElevatedButton(
                  onPressed: () => controller.logout(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff469110),
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  child: Text(
                    "Logout",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
        color: _selectedIndex == index ? Color(0xff469110) : Colors.transparent, // Hijau jika dipilih
        borderRadius: BorderRadius.circular(10), // Biar kotaknya rounded
      ),
      child: Icon(icon, color: _selectedIndex == index ? Colors.white : Colors.grey), // Putih jika dipilih
    ),
  );
}
  Widget buildProfileInfo(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff667085),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xffEFFCE7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Color(0xff667085),
              ),
            ),
          ),
        ],
      ),
      
    );
    
  }
    void _onItemTapped(int index) {
  _selectedIndex = index;
}

}
