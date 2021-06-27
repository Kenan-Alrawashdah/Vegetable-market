import 'package:flutter/material.dart';
import 'DBHelper.dart';
import 'Model/category.dart';
import 'Model/product.dart';
import 'ShowProduct.dart';

class HomPage extends StatefulWidget {
  @override
  _HomPageState createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {

   List<Category> categorys = [];
   List<Product> products = [];
   List<Map<String, dynamic>>productsFDB = [];
   DBHelper db = DBHelper();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categorys.add(Category('Vegetables', 'assets/Images/vegetables.png'));
    categorys.add(Category('Fruits', 'assets/Images/fruits.png'));
    categorys.add(Category('Bakery', 'assets/Images/bakery.png'));
    categorys.add(Category('Drinks', 'assets/Images/drinks.png'));
    addProductsToList();
     addProductToDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 35, top: 10, left: 7),
            child: Text(
              'Categorys',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          row1(),
        ],
      ),
    );
  }

  Widget row1() {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(categorys.length, (index) {
          return InkWell(
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Image(
                      image: AssetImage(categorys[index].iamge),
                      height: 190,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    categorys[index].name,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),
            onTap: () async{
              Navigator.push(context, MaterialPageRoute(builder:(context) => SowProducts(category:categorys[index].name)));

            },
          );
        }),
      ),
    );
  }

    addProductsToList(){
      products.add(Product(name:'Tomato',category:'Vegetables',
          unitPrice: 1.3,unit: 'Kg',image:'assets/Images/tomato.png',
           description: 'They are usually red, scarlet, or yellow, though green and purple'
               ' varieties do exist, and they vary in shape from almost spherical to oval'
               ' and elongate to pear-shaped.'));//v
      products.add(Product(name:'Cucumber ',category:'Vegetables',unitPrice: 1.5,
                           unit: 'Kg',image:'assets/Images/cucumber.png',
                          description: 'The cucumber fruit varies in shape but is '
                              ' generally a curved cylinder rounded at both ends '
                              'that can reach up to 60 cm (24 in) in length 10 cm '));//v
      products.add(Product(name:'Potato',category:'Vegetables',unitPrice: 1, unit: 'Kg',
                            image:'assets/Images/potato.png',
                           description: 'is one of some 150 tuber-bearing species of'
                               ' the genus Solanum (a tuber is the swollen end of an '
                               'underground stem). The compound leaves are spirally'
                               ' arranged; each leaf is 20–30 cm (about 8–12 inches) '
                               'long and consists of a terminal leaflet and two to four'
                               ' pairs of leaflets.' ));//v
      products.add(Product(name: 'strawberries', category: 'Fruits',unit: 'Box',unitPrice: 2,
                            image:'assets/Images/strawberries.png',description: 'is a succulent'
                                  'and fragrant fruit of bright red colour, obtained from the plant '
              '                    with the same name.' ));//f
      products.add(Product(name: 'Onions',category:'Vegetables',unitPrice: 0.8,unit: 'Kg',
                           image:'assets/Images/onions.png',
                            description: 'is a round vegetable with a brown skin that'
                                ' grows underground. It has many white layers on its'
                                ' inside which have a strong, sharp smell and taste.'));//v
      products.add(Product(name:'Zucchini ' , category:'Vegetables',unitPrice: 1.6,unit: 'Kg',
                            image: 'assets/Images/zucchini.png',
                            description: ' is a long, cylindrical vegetable, slightly smaller'
                               ' at the stem end, usually dark green in color. The'
                               ' flesh is a pale greenish-white and has a delicate,'
                               ' almost sweet flavor'));//v
      products.add(Product(name:'Orange',category:'Fruits',unitPrice: 1.5,unit: 'Kg',image:'assets/Images/orange.png',
           description: 'Oranges are round orange-coloured fruit that grow on a tree which'
               ' can reach 10 metres (33 ft) high. Orange trees have dark green shiny leaves'
               ' and small white flowers with five petals. '));//f
      products.add(Product(name:'Grapes' ,category: 'Fruits',description: 'Grapes are a type of fruit that grow in clusters of 15 to 300,'
                          'and can be crimson, black, dark blue, yellow, green, orange, and pink.',
                           unit: 'Kg',unitPrice: 2.5,image:'assets/Images/gape.png',
                           ));//f
      products.add(Product(name:'Apple', unitPrice: 2.3,unit: 'Kg',category:'Fruits',image:'assets/Images/apple.png',
                            description: 'The apple is a pome (fleshy) fruit, in'
                                         'which the ripened ovary and surrounding tissue both become '
                                         'fleshy and edible. ... When harvested, apples are usually roundish,'
                                         '5–10 cm (2–4 inches) in diameter, and some shade of red, green, or'
                                         'yellow in colour; they vary in size, shape, and acidity depending on'
                                          'the variety.'));//f
      products.add(Product(name: 'Pineapple', category: 'Fruits',image:'assets/Images/pineapple.png',unitPrice: 3.5,unit: 'Kg',
                 description:'is a fleshy drupe (stone fruit) that is generally heart-shaped to'
                              'nearly globular, about 2 cm (1 inch) in diameter, and varies in colour'
                               'from yellow through red to nearly black' ));//f
      products.add(Product(name: 'Cherries', category: 'Fruits',image:'assets/Images/cherries.png',unitPrice: 4.5,unit: 'Box',
                           description: 'is a fleshy drupe (stone fruit) that is generally heart-shaped to'
                           'nearly globular, about 2 cm (1 inch) in diameter, and varies in colour'
                           'from yellow through red to nearly black'));//f
      products.add(Product(name: 'Banana', category: 'Fruits',image:'assets/Images/banana.png',unitPrice: 1.2,unit: 'Kg',
                           description: 'is a lengthy yellow fruit, found in the market in groups of three to'
                           'twenty fruits, similar to a triangular cucumber, oblong and normally yellow.'
                           'Its flavour is more or less sweet, depending on the variety. Nutrition and eating.'));//f
      products.add(Product(name: 'Eggplant',category: 'Vegetables',unitPrice: 0.8,unit: 'Kg',
          image:'assets/Images/eggplant.png',
          description: 'Eggplant, a warm-season vegetable belongs to the nightshade family. It forms a many'
                         'branched plant with leaves and stems that have star-shaped (stellate) hair'
                         'and stems.' ));//v
      products.add(Product(name: 'Cabbage',category: 'Vegetables',unitPrice: 0.6,unit: 'Kg',
                   image:'assets/Images/cabbage.png' ));//v
      products.add(Product(name: 'Crowson',category:'Bakery' ,unit:'Piece' ,unitPrice:0.75 ,
          image: 'assets/Images/crowson.png',
                   description: 'This artisan bread is for beginners, but even bread masters will'
                       'appreciate its flavor and ease. It’s so fresh, so flavorful, and so'
                       'surprisingly easy because it basically makes itself.'));//b
      products.add(Product(name:'Sliced Bread',category:'Bakery' ,unit:'Kg' ,unitPrice:0.5 ,
          image: 'assets/Images/bpantry.png',
          description: 'Make dough up to first rising, placing it in a well greased'
                       ' bowl, turning it once to grease the dough all over'));//b
      products.add(Product(name:'Bread',category:'Bakery' ,unit:'Kg' ,unitPrice:0.35 ,
          image: 'assets/Images/bread2.png',
          description: 'Pita bread is freezer friendly. And you can even prepare'
              '         the dough ahead. Be sure to read through for tips and my step-by-step tutorial.'));//b
      products.add(Product(name:'Water Fiji' ,category:'Drinks' ,image:'assets/Images/fiji.png' ,
          unit:'bottle',unitPrice:0.35,description:'is a carbonated soft drink manufactured by PepsiCo.'
                                                  'Originally created and developed in 1893 by Caleb Bradham'
                                                   ' and introduced as Brad s Drink, it was renamed'
                                                     'as Pepsi-Cola in 1898, and then shortened to Pepsi in 1961.'));//d
      products.add(Product(name:'Pepsi' ,category:'Drinks' ,image:'assets/Images/pepsi.png',
          unit:'bottle',unitPrice:0.40,
           description: 'is a tropical island nation located in Oceania in the'
                         'South Pacific Ocean and comprises an archipelago of'
                          'more than 332 islands, 110 of which are permanently inhabited.'));//d
      products.add(Product(name:'7_Up' ,category:'Drinks' ,image:'assets/Images/sevenup.jpg',
          unit:'bottle' ,unitPrice:0.60,description: 'is an American brand of lemon-lime-flavored non-caffeinated soft drink.'
                                                      'The rights to the brand are held by Keurig Dr Pepper in the United States'
                                                       'and by 7 Up international in the rest of the world.' ));//d
      products.add(Product(name:'RedPull' ,category:'Drinks' ,image:'assets/Images/redpull.png',
          unit:'bottle',unitPrice:1,description:'any beverage that contains high levels of a stimulant ingredient, usually'
                                                'caffeine, as well as sugar and often supplements, such as vitamins or'
                                                ' carnitine, and that is promoted as a product capable of enhancing mental'
                                                'alertness and physical performance.'));//d
    }

    addProductToDB()async{
      productsFDB = await db.checkTableProduct();
      if(productsFDB.length == 0){
      for(int i=0; i< products.length; i++){
          db.addNewProduct(products[i]);
      }}
    }
}
//

//


//

//