import 'package:flutter/material.dart' hide Colors;
import 'package:get/get.dart';


import '../controller/database_controller.dart';
import '../model/user.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../widgets/text_input.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  final _databaseController =  DatabaseController.instance;

  late double _deviceWidth, _deviceHeight;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
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
                child: Text("Sign Up" ,style: Styles.SignUpTitle, textAlign: TextAlign.start),
              ),
              TextInput(
                title: "User Name",
                width: _deviceWidth * 0.9,
                controller: nameController,
                type: TextInputType.text,
                inputLength: 20,
                obsText: false,
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
                    _registerUser();
                  },
                  textColor: Colors.white,
                  minWidth: _deviceWidth * 0.35,
                  child: Text('Sign Up'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.1),
                    child: Text("Already registred ? Sign In" , style: Styles.urlText),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _registerUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    List<User> users = await _databaseController.getUsers();

    if (name.isEmpty || email.isEmpty || password.isEmpty ) {
      Get.snackbar('Warning', 'Please fill all fields',backgroundColor: Colors.primaryColor,colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white)
      );
      DatabaseController.instance.printUsers();
      return;

    }

    User newUser = User(userName: name, email: email, password: password);
    int id = await _databaseController.insertUser(newUser);
    if (id != null) {
      Get.snackbar('Success', 'User registered successfully',backgroundColor: Colors.green,colorText: Colors.white,
          icon: Icon(Icons.check, color: Colors.white),
      );
      Get.to(LoginPage());
      nameController.text = "";
      emailController.text = "";
      passwordController.text = "";

    } else {
      Get.snackbar('Warning', 'Something went wrong',backgroundColor: Colors.primaryColor,colorText: Colors.white,
          icon: Icon(Icons.warning, color: Colors.white)
      );

    }
  }
}
