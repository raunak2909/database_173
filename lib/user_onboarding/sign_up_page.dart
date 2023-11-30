import 'package:database_173/app_db.dart';
import 'package:database_173/model/user_model.dart';
import 'package:database_173/user_onboarding/login_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Create Account'),
          SizedBox(
            height: 21,
          ),
          TextField(
            controller: nameController,
          ),
          SizedBox(
            height: 11,
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
          ElevatedButton(onPressed: () async{
            if (nameController.text.isNotEmpty &&
                emailController.text.isNotEmpty &&
                passController.text.isNotEmpty) {
              var appDb = AppDataBase.instance;

              var check = await appDb.createAccount(UserModel(user_id: 0,
                  user_name: nameController.text.toString(),
                  user_email: emailController.text.toString(),
                  user_pass: passController.text.toString()));

              var msg = "";

              if(check){
                msg = "Account created successfully!!";
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
              } else {
                msg = "Can't create account as email already exists!!";
              }

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
            }
          }, child: Text('Sign-Up')),

          TextButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
          }, child: Text('Already have an Account, Login now'))
        ],
      ),
    );
  }
}
