import 'package:database_173/app_db.dart';
import 'package:database_173/main.dart';
import 'package:database_173/user_onboarding/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hi, Welcome back!',
            style: TextStyle(fontSize: 34),
          ),
          SizedBox(
            height: 21,
          ),
          TextField(
            controller: emailController,
          ),
          SizedBox(
            height: 11,
          ),
          TextField(
            controller: passController,
          ),
          SizedBox(
            height: 21,
          ),
          ElevatedButton(
              onPressed: () async {
                if (emailController.text.isNotEmpty &&
                    passController.text.isNotEmpty) {
                  var email = emailController.text.toString();
                  var pass = passController.text.toString();

                  var appDB = AppDataBase.instance;

                  if (await appDB.authenticateUser(email, pass)) {


                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Email and Password!!')));
                  }
                }
              },
              child: Text('Login')),
          TextButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
          }, child: Text('New User? Create Account now'))
        ],
      ),
    );
  }
}
