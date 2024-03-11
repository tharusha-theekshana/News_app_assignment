import 'package:flutter/material.dart' hide Colors;
import 'package:get/get.dart';
import 'package:news_app_assignment/screens/register_page.dart';


import '../controller/database_controller.dart';
import '../model/user.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../widgets/text_input.dart';
import 'dashboard_screen.dart';


class LoginPage extends StatelessWidget {
  final _databaseController =  DatabaseController.instance;

  late double _deviceWidth, _deviceHeight;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: _deviceWidth,
          height: _deviceHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: _deviceHeight * 0.25,
                width: _deviceWidth * 0.5,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/logo.png'))),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.02),
                width: _deviceWidth * 0.9,
                child: Text("Sign In" ,style: Styles.SignUpTitle, textAlign: TextAlign.start),
              ),
              TextInput(
                  title: "Email",
                  width: _deviceWidth * 0.9,
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  inputLength: 100,
                  obsText: false),
              TextInput(
                  title: "Password",
                  width: _deviceWidth * 0.9,
                  controller: passwordController,
                  type: TextInputType.text,
                  inputLength: 20,
                  obsText: true),
              SizedBox(
                height: _deviceHeight * 0.05,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Set border radius here
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.errorColor, Colors.primaryColor], // Set your gradient colors
                  ),// Example background color
                ),
                child: MaterialButton(
                  onPressed: () {
                    _login();
                  },
                  textColor: Colors.white,
                  minWidth: _deviceWidth * 0.35,
                  child: const Text('Sign In'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) =>  RegisterPage()),
                        (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.1),
                  child: Text("Don't Have an account ? Sign Up" , style: Styles.urlText),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty) {
      Get.snackbar('Warning', 'Please enter email',backgroundColor: Colors.primaryColor,colorText: Colors.white,
          icon: Icon(Icons.warning, color: Colors.white)
      );
      return;
    }else if(password.isEmpty){
      Get.snackbar('Warning', 'Please enter password',backgroundColor: Colors.primaryColor,colorText: Colors.white,
          icon: Icon(Icons.warning, color: Colors.white)
      );
      return;
    }

    List<User> users = await DatabaseController.instance.getUsers();
    User user = users.firstWhere((user) => user.email == email, orElse: () {
      return User(userName: "", email: "", password: "");
    },);

    if (user.email == "" || user.password == "") {
      Get.snackbar('Login failed', 'Invalid user',backgroundColor: Colors.primaryColor,colorText: Colors.white,
          icon: Icon(Icons.warning, color: Colors.white)
      );
    } else {
      if (user.password == password && user.email == email) {
        Get.snackbar('Success', 'Login successfully',backgroundColor: Colors.green,colorText: Colors.white,
          icon: Icon(Icons.check, color: Colors.white),
        );
        Get.to(DashboardScreen());
        emailController.text = "";
        passwordController.text = "";
      } else {
        Get.snackbar('Warning', 'Something went wrong',backgroundColor: Colors.primaryColor,colorText: Colors.white,
            icon: Icon(Icons.warning, color: Colors.white)
        );
      }
    }
  }
}
