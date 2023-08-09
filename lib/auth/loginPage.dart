import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kwetu/services/authServices.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String userName = " ";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    children: <Widget> [
                      const Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),

                      userNameBox(),
                      const SizedBox(height: 20,),
                      passwordBox(),
                      const SizedBox(height: 20,),
                      loginButton(),
                      createAccountPage(),
                      const SizedBox(height: 100,),
                      creditPart()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }

  userNameBox() {
    return Container(
      padding: const EdgeInsets.only(top: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: userNameController,
            decoration: InputDecoration(
              labelText: "UserName",
              labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
              hintText: "Enter UserName Here",
              prefixIcon: const Icon(Icons.person_2_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            validator: (val){
              if(userNameController.text.length < 1){
                return "Username can't be empty";
              }
            },
          )
        ],
      ),
    );
  }

  passwordBox() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          TextFormField(
            controller: userNameController,
            decoration: InputDecoration(
              hintText: "Enter Password Here",
              labelText: "Password",
              labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            validator:(val){
              if(passwordController.text.length < 8){
                return "Password must be at least 8 characters";
              }
          },
          )
        ],
      ),
    );
  }

  createAccountPage(){
    return Text.rich(
        TextSpan(
          text: "Don't have an account?",
          style: TextStyle(),
          children: <TextSpan>[
            TextSpan(
              text: " Sign up here",
              style: TextStyle(color: Theme.of(context).primaryColor),
              recognizer: TapGestureRecognizer()..onTap = (){

              }
            )
          ]

        ));
  }

  loginButton(){
    return  Container(
      padding: EdgeInsets.only(top: 20),
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              )
          ),
          onPressed: (){
            login();
          },
          child: const Text( "login" )),
    );
  }

  creditPart(){
    return Column(
      children: const [
        Text("DEVELOPED BY", style: TextStyle(fontWeight: FontWeight.bold),),
        Text("@ mobileIbra"),
      ],
    );
  }

  login() async{
    if(formKey.currentState!.validate());
    setState(() {
      userName = userNameController.text;
      password = passwordController.text;
    });

    await databaseServices(uid: FirebaseAuth.instance.currentUser!.uid).signInWIthUSernameAndPasssword(userName, password).then((value){
      if(value == true){
         //saving datas to shared preferences and move to next page
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("UserName Or Password Is Not Correct"),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red,
            ))
      }
    });

  }
}
