import 'package:flutter/material.dart';
import 'package:footwareclient/controller/login_controller.dart';
import 'package:footwareclient/pages/login_page.dart';
import 'package:footwareclient/widgets/otp_txt_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      //assignId: true,
      builder: (ctrl) {
        return Scaffold(
          body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(30),
            color: Colors.blueGrey[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create Your Account !!",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: ctrl.registerNameCtrl,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: "Your Name",
                    hintText: "Enter Your Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: ctrl.registerNumberCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: "Your Number",
                    hintText: "Enter Your Number",
                    prefixIcon: Icon(Icons.phone_android),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                OtpTextField(
                  otpController: ctrl.otpController,
                  visble: ctrl.otpFieldShown,
                  onComplete: (otp) {
                    ctrl.otpEnterd = int.tryParse(otp ?? '0000');
                  },),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 180,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      if(ctrl.otpFieldShown){
                        ctrl.addUser();
                      } else {
                        ctrl.sendOtp();
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: Text(
                   ctrl.otpFieldShown ? 'Register' :  "Send OTP",
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(const LoginPage());
                  },
                  child: Text("Login"),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
