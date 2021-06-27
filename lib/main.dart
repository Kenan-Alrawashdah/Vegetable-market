import 'package:flutter/material.dart';
import 'package:hw_project/SpecificProduct.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DrawerPage.dart';
import 'ShowBasket.dart';
import 'ShowProduct.dart';
import 'homPage.dart';
import 'login.dart';

void main()async => runApp(MaterialApp(
  title: 'MyApp',
  theme: ThemeData(primarySwatch: Colors.green),
  debugShowCheckedModeBanner: false,

  initialRoute:await checkLogin()? '/' : '/log' ,
  routes: {
    '/': (context)=>DrawerPage(),
    '/hom':(context)=>HomPage(),
    '/sho':(context)=>SowProducts(),
    '/pro':(context)=>SpecificProduct(),
    '/log':(context)=>Login(),
    '/bas':(context)=>ShowBasket(),
  },
));
     

   Future<bool> checkLogin()async{
     WidgetsFlutterBinding.ensureInitialized();
   final prefs = await SharedPreferences.getInstance();
     if (prefs.containsKey('email'))
         return true;
     return false;
  }


