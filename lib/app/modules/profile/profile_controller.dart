import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class ProfileController extends GetxController {
  var sessionBox = Hive.box('session');

  Stream<DocumentSnapshot> getUserData() {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      return FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    }
    return const Stream.empty();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    await sessionBox.clear();
    Get.offAllNamed('/login');
  }
}