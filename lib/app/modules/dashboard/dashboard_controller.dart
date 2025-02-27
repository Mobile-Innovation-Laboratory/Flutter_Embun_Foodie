import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var selectedCategory = 'All'.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  Stream<QuerySnapshot> getRecipes() {
    if (selectedCategory.value == 'All') {
      return FirebaseFirestore.instance.collection('recipes').snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('recipes')
          .where('category', isEqualTo: selectedCategory.value)
          .snapshots();
    }
  }
}
