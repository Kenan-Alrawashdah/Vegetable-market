import 'package:flutter/material.dart';
import 'package:hw_project/DBHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/basket.dart';
import 'Model/product.dart';
import 'Utility.dart';


  class SpecificProduct extends StatefulWidget {
    @override
    _SpecificProductState createState() => _SpecificProductState();
  }

  class _SpecificProductState extends State<SpecificProduct> {
     int quantity = 0 ;
     int numberProduct = 0;
     String expation = '';
     DBHelper db = DBHelper();


     @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNumberProduct();
  }

    @override
    Widget build(BuildContext context) {
      Product product = ModalRoute.of(context).settings.arguments;
      return Scaffold(
         appBar: AppBar(
           actions: [
             Stack(children: [
               IconButton(
                 icon: Icon(
                   Icons.shopping_basket_outlined,
                   color: Colors.white,
                   size: 30,
                 ),
                 onPressed: () async{
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
         body:  Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             //cont1
             Container(
               //Utility.imageFromBase64String(product.image,600,240),
               child:  Image(image: AssetImage(product.image),height: 240,width: 600,) ,
             ),
             //cont2
             Container(
               margin: EdgeInsets.only(left: 20,right: 5),
               child: Row(
                 children: [
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           padding: EdgeInsets.only(bottom: 7),
                           child: Text( product.category,
                             style: TextStyle(
                                 color: Colors.grey, fontSize: 17),
                           ),
                         ),
                         Container(
                           child: RichText(
                             text: TextSpan(
                                 children: [
                                   TextSpan(
                                     text: '${product.name}',
                                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
                                   ),
                                   TextSpan(
                                     text: ' : \$${product.unitPrice} ${product.unit}',
                                     style: TextStyle(color: Colors.blue,fontSize: 20),
                                   ),
                                 ]
                             ),
                           )

                         )
                       ],
                     ),
                   ),
                   Container(
                     margin: EdgeInsets.only(top: 20),
                     decoration: BoxDecoration(
                       border: Border.all(
                         color: Colors.green
                       ),
                       borderRadius: BorderRadius.circular(25)
                           
                     ),
                     child: Row(
                       children: [
                         IconButton(
                           icon: Icon(Icons.remove),
                           color: Colors.red,
                           iconSize: 25,
                           onPressed: () {
                             if(quantity> 0 ){
                               setState(() {
                                 quantity --;
                               });

                             }
                           },
                         ),
                         Text('$quantity ${product.unit}',style: TextStyle(fontSize: 16),),
                         IconButton(
                           icon: Icon(Icons.add),
                           color: Colors.green,
                           iconSize: 25,
                           onPressed: () {
                             setState(() {
                               quantity++;
                               expation = '';
                             });
                           },
                         ),
                       ],
                     ),
                   )
                 ],
               ),
             ),
             //cont4
             Container(
               margin: EdgeInsets.only(left: 25, top: 40),
               child: Text( 'Description : ${product.description}',
               softWrap: true,
               style: TextStyle(fontSize: 20,color: Colors.grey),
             ),),

             Container(
                margin: EdgeInsets.only(top: 50),
               child: Center(child: Text(expation, style: TextStyle(color: Colors.red),),),)
           ],
         ),
        floatingActionButton: FloatingActionButton.extended(onPressed: ()async{
               if(quantity > 0 ){
                 expation = '';
                 final prefs = await SharedPreferences.getInstance();
                   Basket order = Basket(name: product.name,
                                          unit: product.unit,
                                          unitPrice: product.unitPrice,
                                           quantity: quantity,
                                           image: product.image);
                   db.addOrder(order);
                 setState(() {
                   numberProduct++;
                   prefs.setInt('numberPr', numberProduct);
                 });
               }else{
                   setState(() {
                     expation = 'Please specify the quantity of the product';
                   });
               }
        }, label: Text('Add to Cart'),
          icon: Icon(Icons.shopping_basket_outlined),
          backgroundColor: Colors.green,),
      );
    }

     void getNumberProduct()async{
     List<Map<String, dynamic>> data = await db.getAllOrder();
       numberProduct = data.length;
       setState(() {

       });
     }

  }


