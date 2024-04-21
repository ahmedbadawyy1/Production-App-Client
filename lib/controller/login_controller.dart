import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footwareclient/models/user/user.dart';
import 'package:footwareclient/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class LoginController extends GetxController {

  GetStorage  box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerNumberCtrl = TextEditingController();
  TextEditingController loginNumberCtrl = TextEditingController();

  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  bool otpFieldShown = false;
  int? otpSend;
  int? otpEnterd;

  User? loginUser;
  @override
  void onReady(){
    Map<String, dynamic>? user = box.read('loginUser');
    if(user != null){
      loginUser == User.fromJson(user);
      Get.to(const HomePage());
    }
    super.onReady();
  }


  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  addUser() {
    try {
      if (otpSend == otpEnterd) {
        DocumentReference doc = userCollection.doc();
        User user = User(
          id: doc.id,
          name: registerNameCtrl.text,
          number: int.parse(registerNumberCtrl.text),
        );
        final userJson = user.toJson();
        doc.set(userJson);
        Get.snackbar("Success", 'User added successfully',
            colorText: Colors.green);
        registerNameCtrl.clear();
        registerNumberCtrl.clear();
        otpController.clear();
      } else {
        Get.snackbar("error", "OTP is incorrect", colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar("error", e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  sendOtp() {
    try {
      if (registerNumberCtrl.text.isEmpty || registerNameCtrl.text.isEmpty) {
        Get.snackbar("error", 'please fill the fields', colorText: Colors.red);
        return;
      }

      final random = Random();
      int otp = 1000 + random.nextInt(9000);
      print(otp);
      if (otp != null) {
        otpFieldShown = true;
        otpSend = otp;
        Get.snackbar("success", "OTP send successfully",
            colorText: Colors.green);
      } else {
        Get.snackbar("error", "Otp not send !!", colorText: Colors.red);
      }
    } catch (e) {
      print(e);
    } finally {
      update();
    }
  }

  Future<void> loginWithPhone() async {
    try {
      String phoneNumber = loginNumberCtrl.text;
      if (phoneNumber.isNotEmpty) {
        var querSnaphot = await userCollection
            .where('number', isEqualTo: int.parse(phoneNumber))
            .limit(1)
            .get();
        if (querSnaphot.docs.isNotEmpty) {
          var userDoc = querSnaphot.docs.first;
          var userData = userDoc.data() as Map<String, dynamic>;
          box.write("loginUser", userData);
          loginNumberCtrl.clear();
          Get.to(const HomePage());
          Get.snackbar("success", "Login Successful", colorText: Colors.green);
        } else {
          Get.snackbar("Error", "User not found, please register ",
              colorText: Colors.red);
        }
      } else {
        Get.snackbar("Error", "Please enter a phone number ",
            colorText: Colors.red);
      }
    } catch (error) {
      print("Faild to login $error");
    }
  }
}
