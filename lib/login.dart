import 'package:flutter/material.dart';
import 'package:hw_project/DBHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'signUp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var styleTitle = TextStyle(fontSize: 70, fontWeight: FontWeight.bold, );
   TextEditingController email = TextEditingController();
   TextEditingController password = TextEditingController();
   String exption ='';
  DBHelper db = DBHelper();
  List<Map<String, dynamic>> data=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          physics:ScrollPhysics() ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              row1(),
              Container(
                margin: EdgeInsets.only(top: 30),
                  child: Center(child: Image(image: AssetImage('assets/Images/logo.png'),width: 150,height: 115,fit: BoxFit.cover,))),
              erorrDes(),
              row2(),
              row3(),
              SizedBox(height: 7,),
              row4(),
              SizedBox(height: 15,),
              row5(),
              SizedBox(height: 20,),
              row6(),
              SizedBox(height: 20,),
              row7(),
              SizedBox(height: 5,),
            ],
          ),)
    );
  }

  Widget row1(){
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, left: 15),
            child:Text('Hello', style: styleTitle,) ,
          ),
          Container(
            padding: EdgeInsets.only(top: 105, left: 19),
            child:Text('There', style: styleTitle,) ,
          ),
          Container(
            padding: EdgeInsets.only(top: 105, left: 200),
            child:Text('.', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 70),) ,
          ),
        ],
      ),
    );
  }

  Widget row2(){
    return Container(
      padding: EdgeInsets.only(top: 15, left: 20, right: 20),
      child: TextField(
         keyboardType: TextInputType.text ,
         controller: email,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.green,width: 2)),
        ),
      ),
    );
  }
  Widget row3(){
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
      alignment: Alignment(1.0,0.0),
      padding: EdgeInsets.only(top: 16,left:20,right: 19 ),
      child: InkWell(
        child: Text('Forgot Password',style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
            decoration: TextDecoration.underline
        ),),),
    );
  }
  Widget row5(){
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20),
      height: 50,
      child: Material(
        borderRadius: BorderRadius.circular(25),
        color: Colors.green,
        elevation: 2,
        child: InkWell(
          onTap: ()async {
            if( email.text.isNotEmpty){
              exption = '';
              if(password.text.isNotEmpty){
                data = await db.checkEmailAndPassword(email.text, password.text) ;
                // print('Email: ${data[0]['email']}');
                if(data.isNotEmpty){
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString('firstName',data[0]['firstName'] );
                  prefs.setString('lastName',data[0]['lastName'] );
                  prefs.setString('email',data[0]['email'] );
                  Navigator.pushNamed(context, '/');
                }else{
                  setState(() {
                    exption = 'Please enter the correct information "Email", "Password"';
                  });

                }
              }else{
                exption = 'Please enter the password!';
              }
            }else{
              exption = 'Please enter the email!';
              setState(() {

              });
            }
          },
          child: Center(child: Text('LOGIN',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),),),
        ),
      ),
    );
  }
  Widget row6(){
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(AssetImage('assets/Images/face.png')),
              SizedBox(width: 10,),
              Text('Log in with Facebook',style: TextStyle(color: Colors.black,fontSize: 17, fontWeight: FontWeight.bold),),
            ],
          ),
          onTap: () {
            print('Facebook');
          },),
      ),

    );
  }
  Widget row7(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('New to Spotify ?',style: TextStyle(fontSize: 16),),
        SizedBox(width: 5,),
        InkWell(child: Text('Register',style: TextStyle(
          fontSize: 16,
          color: Colors.green,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,

        ),),
          onTap: () async{
           await Navigator.push(context, MaterialPageRoute(
                builder: (context) => SignUp()));
            setState(() {
                exption = '';
            });
          },),

      ],
    );
  }
  Widget erorrDes(){
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,top: 20,),
      child: Center(
        child: Text(exption, style: TextStyle(color: Colors.red),),
      ),

    );
  }
}