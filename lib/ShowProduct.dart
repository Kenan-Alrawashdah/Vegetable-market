import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hw_project/DBHelper.dart';
import 'package:hw_project/Model/product.dart';
import 'package:hw_project/Utility.dart';



class SowProducts extends StatefulWidget {
  final String category ;
  SowProducts({this.category}):super();
  @override
  _SowProductsState createState() => _SowProductsState();
}

class _SowProductsState extends State<SowProducts> {

    List<Map<String, dynamic>> data=[];

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(widget.category);
  }
    DBHelper db = DBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(''),),
      body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 35, top: 10, left: 7),
            child: Text(
              'Products',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(data.length, (index) {
                return InkWell(
                  child: Container(
                    //margin: EdgeInsets.all(15),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5,bottom: 15),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            //image(data[index]['image'])
                            child: Image(image: AssetImage(data[index]['image']),height: 100,width: 150,) ,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                data[index]['name'],
                                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '\$${data[index]['unitPrice']}',
                                    style: TextStyle(fontSize: 15, color: Colors.blue),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    '/${data[index]['unit']}',
                                    style: TextStyle(fontSize: 15, color: Colors.grey),
                                  ),
                                  /*IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    onPressed: () async {
                                      await db.deleteProduct(data[index]['id']);
                                      setState(() {

                                      });
                                    },
                                  ),*/
                                ],),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                     Product p = Product(name:data[index]['name'], description: data[index]['description'],
                                          unit: data[index]['unit'],category:data[index]['category'],
                                          unitPrice: data[index]['unitPrice'],
                                          image: data[index]['image'],);
                    Navigator.pushNamed(context, '/pro', arguments: p);

                  },
                );
              }),
            ),
          ),

        ],
      ),
    );
  }

  getData(String str) async{
    data = await db.getAllProduct(str);
    setState(() {

    });
  }
    Widget image(String thumbnail) {
      String placeholder = "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==";
      if (thumbnail?.isEmpty ?? true)
        thumbnail = placeholder;
      else {
        if (thumbnail.length % 4 > 0) {
          thumbnail += '=' * (4 - thumbnail .length % 4); // as suggested by Albert221
        }
      }

      Widget image = Utility.imageFromBase64String(thumbnail, 150,100);

      return image;
    }
  Widget row1() {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(5, (index) {
          return InkWell(
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Text(''),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'keanna',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),
            onTap: () {
              print('item$index');
            },
          );
        }),
      ),
    );
  }
}
