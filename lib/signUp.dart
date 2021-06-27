import 'package:flutter/material.dart';
import 'package:hw_project/DBHelper.dart';
import 'package:hw_project/Model/user.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var styleTitle = TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.black);

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String exption = '';
  DBHelper db = DBHelper();

  List<Map<String, dynamic>> data=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            row1(),
            erorrDes(),
            styleTextField('First Name', firstName),
            styleTextField('Last Name', lastName),
            emailTextField(),
            passwordTextField(),
            SizedBox(height: 50,),
            row4(),
            SizedBox(height: 25,),
            row5(),
          ],
        ),
      ),
    );
  }

  Widget row1(){
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 70, left: 15),
            child:Text('Create', style: styleTitle,) ,
          ),
          Container(
            padding: EdgeInsets.only(top: 135, left: 19),
            child:Text('Account', style: styleTitle,) ,
          ),
          Container(
            padding: EdgeInsets.only(top: 130, left: 245),
            child:Text('.', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 70),) ,
          ),
        ],
      ),
    );
  }

  styleTextField(String str, TextEditingController con){
    return Container(
      padding: EdgeInsets.only(top: 15, left: 20, right: 20),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: con,
        decoration: InputDecoration(
          labelText: str,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.green,width: 2)),
        ),
      ),
    );
  }

  Widget emailTextField(){
    return Container(
      padding: EdgeInsets.only(top: 15, left: 20, right: 20),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: email,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.green,width: 2)),
        ),
      ),
    );
  }


  Widget passwordTextField(){
    return Container(
      padding: EdgeInsets.only(top: 15, left: 20, right: 20),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: password,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green,width: 2)
          ),
        ),
        obscureText: true,
      ),
    );
  }

  Widget row4(){
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20),
      height: 50,
      child: Material(
        borderRadius: BorderRadius.circular(25),
        color: Colors.green,
        elevation: 2,
        child: InkWell(
          onTap: () async{
            if(firstName.text.isNotEmpty && firstName.text.length >= 3 ){
              print('fff');
              exption = '';
              setState(() {

              });
              if(lastName.text.isNotEmpty && lastName.text.length >= 3){
                print('lll');
                if(validateEmail(email.text)){
                  print('eee');
                  if(password.text.isNotEmpty && password.text.length >=8 ){
                        data = await db.checkEmail(email.text);
                        if(data.isEmpty) {
                          User user = User(firstName: firstName.text,
                              lastName: lastName.text,
                              email: email.text,
                              password: password.text);
                          db.addNewUser(user);
                          Navigator.pushNamed(context, '/log');
                        }else{
                          exption = 'The email is already in use, please add another email!';
                          setState(() {

                          });
                        }

                  }else{
                    exption = 'Please, the password must be greater or equal to eight characters!';
                  }
                }else{
                  exption = 'Please, the e-mail must be in a correct format!';
                }
              }else{
                exption = 'Please last name must be at least 3 characters long!';
              }
            }
            else{
              exption = 'Please first name must be at least 3 characters long!';
              setState(() {

              });
            }

          },
          child: Center(child: Text('Sign Up',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),),),
        ),
      ),
    );
  }

  Widget row5(){
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20),
      height: 50,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, style: BorderStyle.solid,width: 3),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: InkWell(
          child: Center(child: Text('Log in',style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),),),
          onTap: () {
           Navigator.pop(context);
          },),
      ),

    );
  }

  Widget erorrDes(){
    return Container(
      margin: EdgeInsets.all(15),
      child: Center(
      child: Text(exption, style: TextStyle(color: Colors.red),),
    ),

           );
  }
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
}