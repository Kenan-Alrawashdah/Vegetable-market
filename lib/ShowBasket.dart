import 'package:flutter/material.dart';
import 'package:hw_project/DBHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utility.dart';


class ShowBasket extends StatefulWidget {
  @override
  _ShowBasketState createState() => _ShowBasketState();
}

class _ShowBasketState extends State<ShowBasket> {
    var styleLabel = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
     String firstName ='';
     String lastName ='';
     DBHelper db = DBHelper();
     double priceTotal = 0.0;
    List<Map<String, dynamic>> data=[];

    int numberProduct = 0;
     @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShPrefs();
    getPriceTotale();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Basket'),),
      body: Column(
        children: [
           row1(),
           row2(),

        ],
      ),
    );
  }
  Widget row1(){
    return Card(
      color: Colors.grey,
      margin: EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 40),
       child: Container(
           margin: EdgeInsets.only(left: 15),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(height: 10,),
             Center(child: Text('Bill',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),),),
             SizedBox(height: 10,),
             Text('Nam : $firstName $lastName',style: styleLabel,),
             SizedBox(height: 10,),
             Text('PriceTotal : \$$priceTotal   '.substring(0, 18),style: styleLabel,),
             SizedBox(height: 10,),
             Text('Time : ${DateTime.now()
                 .toString()
                 .substring(0,16)} ',style: styleLabel,),
             SizedBox(height: 10,),
           ],
         ),
       ),
    );
  }
  Widget row2(){
       return Flexible(child: data.length == 0 ? Text('No Item...'):ListView.builder(itemCount: data.length,itemBuilder: (context, index) {
         return ListTile(
           //Utility.imageFromBase64String(data[index]['image'], 100,100)
             leading: Image(image: AssetImage(data[index]['image']),height: 100,width: 70,) ,
           title: Row(
             children: [
               Text(data[index]['name'],style:TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20),),
               SizedBox(width: 10,),
               Text('\$${data[index]['unitPrice']}/${data[index]['unit']}'),
             ],
           ),
           subtitle: Container(
             margin: EdgeInsets.only(bottom: 10),
             child: Row(
               children: [
                 Text('Quantity : ${data[index]['quantity']} ${data[index]['unit']}'),
                 Text('Total : \$${data[index]['quantity']* data[index]['unitPrice']}  '.substring(0,12)),
               ],
             ),
           ),
           trailing: IconButton(icon: Icon(Icons.delete, color: Colors.red,),onPressed: () async{
               await db.deleteOrder(data[index]['id']);
               getPriceTotale();
               data = await db.getAllOrder();
             setState(() {

             });
           },),
         );

       },)
             );
  }

    void getShPrefs()async{
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        firstName = prefs.getString('firstName') ?? '';
        lastName = prefs.getString('lastName') ?? '';
      });

    }



    getPriceTotale()async{
      data = await db.getAllOrder();
      priceTotal = 0 ;
      for(int i = 0; i < data.length ; i++ ){
         priceTotal += (data[i]['quantity']* data[i]['unitPrice']);
      }
        setState(() {

        });
    }


}
