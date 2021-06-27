import 'package:flutter/material.dart';
import 'package:hw_project/DBHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addProduct.dart';
import 'homPage.dart';
import 'login.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
   Widget page_state = HomPage();
   int numberProduct = 0 ;
   String prefs_firstName = '';
   String prefs_lastName = '';
   String prefs_email = '';
   DBHelper db = DBHelper();
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNumberProduct();
  }
  @override
  Widget build(BuildContext context) {

    getShPrefs();
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 5,
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
            },
          ),
          SizedBox(
            width: 10,
          ),
          Stack(children: [
            IconButton(
              icon: Icon(
                Icons.shopping_basket_outlined,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () async {
                await Navigator.pushNamed(context, '/bas');
                getNumberProduct();
              },
            ),
            Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.only(left: 30, top: 1),
              child: (numberProduct > 0) ? CircleAvatar(child: Text(numberProduct.toString(),style: TextStyle(color: Colors.white,),),
                backgroundColor: Colors.red,
              ) : Text(''),
            )
          ],),
        ],
      ),
      body: page_state,
      drawer: Drawer(
        elevation: 1,
        child: ListView(
          children: [
            DrawerHeader(
                child: Column(
              children: [
                Flexible(
                  child: Container(
                    height: 150,
                    width: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: prefs_firstName.isEmpty? Text(''): Text(
                        '${prefs_firstName.substring(0, 1).toUpperCase()} ${prefs_lastName.substring(0, 1).toUpperCase()}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                Text(
                   '$prefs_firstName $prefs_lastName',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                   prefs_email,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey
                  ),
                )
              ],
            )),
            ListTile(
              title: Text(
                'HomPage',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.home),
              onTap: () {
                setState(() {
                  page_state = HomPage();
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text(
                'AddProduct',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.add_box_outlined),
              onTap: () {
                setState(() {
                  page_state = AddProduct();
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.logout),
              onTap: () async{
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                setState(() {
                  Navigator.pushNamed(context, '/log');
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),

            title: InkWell(child: Text('Home'),onTap:() {
              Navigator.pushNamed(context, '/');
            },),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorite'),
          ),

        ],
      ),
    );
  }
  void getShPrefs()async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs_firstName = prefs.getString('firstName') ?? '';
      prefs_lastName = prefs.getString('lastName') ?? '';
      prefs_email = prefs.getString('email') ?? '';
    });
  }

   void getNumberProduct()async{
     List<Map<String, dynamic>> data = await db.getAllOrder();
     numberProduct = data.length;
     setState(() {

     });
   }
}
