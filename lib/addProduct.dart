import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'DBHelper.dart';
import 'Model/product.dart';
import 'Utility.dart';
import 'homPage.dart';
import 'dart:async';
class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
    DBHelper db = DBHelper();

  List<String> categorys = ['Vegetables', 'Fruits', 'Bakery', 'Drinks'];
  String dropdownChoose = 'Vegetables';

  List<String> units = [
    'Kg',
    'L',
    'Box',
  ];
  String unitChoose = 'Kg';
  String image = '';
  var styleLable = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  String exption = '';
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController unitPrice = TextEditingController();

  pickImageFromGallery() async {
    final myfile = await ImagePicker().getImage(source: ImageSource.gallery);
    image = Utility.base64String(File(myfile.path).readAsBytesSync());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            row1(),
            Text(
              exption,
              style: TextStyle(color: Colors.red),
            ),
            row2(),
            SizedBox(
              height: 20,
            ),
            row3(),
            SizedBox(
              height: 20,
            ),
            row4(),
            SizedBox(
              height: 20,
            ),
            row5(),
            SizedBox(
              height: 20,
            ),
            row6(),
            SizedBox(
              height: 40,
            ),
            row7(),
          ],
        ),
      ),
    );
  }

  Widget row1() {
    return Container(
      margin: EdgeInsets.only(left: 7, top: 10, bottom: 30),
      child: Text(
        'Add Product',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  } //Utility

  Widget row2() {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'Choose Category',
                style: styleLable,
              ),
            ),
            SizedBox(
              width: 40,
            ),
            dropdownButtonC(),
          ],
        )
      ],
    );
  }

  Widget row3() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            'Product Name',
            style: styleLable,
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Flexible(
          child: Container(
            width: 185,
            padding: EdgeInsets.only(bottom: 30),
            child: TextField(
              controller: name,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Enter',
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget row4() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            'Description',
            style: styleLable,
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Flexible(
          child: Container(
            width: 210,
            padding: EdgeInsets.only(left: 26, bottom: 30),
            child: TextField(
              controller: description,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Enter',
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget row5() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            'Unit Price',
            style: styleLable,
          ),
        ),
        SizedBox(
          width: 50,
        ),
        Flexible(
          child: Container(
            width: 210,
            padding: EdgeInsets.only(left: 26, bottom: 30),
            child: TextField(
              controller: unitPrice,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter',
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget row6() {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'Unit',
                style: styleLable,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            dropdownButtonU(),
            SizedBox(
              width: 60,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'Add Image',
                style: styleLable,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              icon: Icon(
                Icons.add_photo_alternate_outlined,
                size: 30,
                color: Colors.blue,
              ),
              onPressed: () {
                pickImageFromGallery();
                print('image: $image');
              },
            )
          ],
        )
      ],
    );
  }

  Widget row7() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: ElevatedButton(
            onPressed: () {
              if (name.text.isNotEmpty) {
                setState(() {
                  exption = '';
                });
                if (description.text.isNotEmpty) {
                  exption = '';
                  if (unitPrice.text.isNotEmpty) {
                      exption = '';
                   Product p = Product(name: name.text, category: dropdownChoose, description: description.text
                                       ,unitPrice: double.parse(unitPrice.text), unit: unitChoose,image: image );
                             db.addNewProduct(p) ;
                  } else {
                    exption = 'Please enter the product "unit price"';
                  }
                } else {
                  exption = 'Please enter a product "description"';
                }
              } else {
                exption = 'Please enter the "Product Name"';
                setState(() {});
              }
            },
            child: Text('Save',
                style: TextStyle(
                  fontSize: 20,
                )),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            ),
          ),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Reset',
                style: TextStyle(
                  fontSize: 20,
                )),
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            ),
          ),
        )
      ],
    );
  }

  Widget dropdownButtonC() {
    return DropdownButton(
      items: categorys
          .map((e) => DropdownMenuItem(
                child: Text(
                  e,
                  style: TextStyle(fontSize: 20),
                ),
                value: e,
              ))
          .toList(),
      value: dropdownChoose,
      onChanged: (value) {
        setState(() {
          dropdownChoose = value;
        });
      },
      icon: Icon(
        Icons.arrow_drop_down,
        size: 35,
        color: Colors.green,
      ),

      //underline: Container(height: 2, color: Colors.green,),
    );
  }

  Widget dropdownButtonU() {
    return DropdownButton(
      items: units
          .map((e) => DropdownMenuItem(
                child: Text(
                  e,
                  style: TextStyle(fontSize: 20),
                ),
                value: e,
              ))
          .toList(),
      value: unitChoose,
      onChanged: (value) {
        setState(() {
          unitChoose = value;
        });
      },
      icon: Icon(
        Icons.arrow_drop_down,
        size: 35,
        color: Colors.green,
      ),

      // underline: Container(height: 2, color: Colors.green,),
    );
  }


}
