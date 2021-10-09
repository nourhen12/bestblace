import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_auth/Screens/user.dart';


class Body extends StatelessWidget {
 var mail;
 var psw;
 final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form( 
          key: _formKey,
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField (
              hintText: "Your Email",
              onChanged: (value) {
                mail = value;
              },
             validate: (value){
                if (value.isEmpty) {
                        return 'Enter something';
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return 'Enter valid email';
                      }
               },
            ),
            RoundedPasswordField(
               onChanged: (value) {
                psw=value;
              },
              validate: (value) {
                      if (value.isEmpty) { 
                          return 'Enter something';
                      }else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                          return 'Enter valid password';
                      }else{
                          return null;}
                    },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                var fromdata=_formKey.currentState;
                 if (fromdata.validate()) {
                   signup(mail, psw) ;
                   Navigator.of(context).pushNamed('accueil');
                  
                  }else{
                    print("notvalid");
                  }
              },
             
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
              Navigator.of(context).pushNamed('login');
               /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );*/
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
         ),
        ),
      ),
    );
  }
} 
Future<User> signup(email, password) async {
  final response = await http.post(
    Uri.parse("https://bestpkace-api.herokuapp.com/users/register"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  print(jsonDecode(response.body));

 /* if (response.statusCode == 200 ) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to register user.');
  }*/
}


