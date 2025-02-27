import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var sessionBox = Hive.box('session');

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      sessionBox.put('userId', userCredential.user?.uid);
      sessionBox.put('email', email.value);

      Get.offNamed('/newrecipe');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
