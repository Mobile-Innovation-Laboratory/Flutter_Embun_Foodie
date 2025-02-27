import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  var fullname = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var password = ''.obs;
  var confirmpassword = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp() async {
    if (password.value != confirmpassword.value) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      String uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'fullname': fullname.value,
        'email': email.value,
        'phonenumber': phoneNumber.value,
        'likedrecipes': [],
      });

      Get.offNamed('/login');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
