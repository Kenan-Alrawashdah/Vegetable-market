class Product{

   int id ;
   String category;
   String name;
   String description;
   double unitPrice;
   String unit;
   String image;
   Product({this.id, this.category, this.name, this.description, this.unitPrice, this.unit,this.image});

   Map<String, dynamic> productRecord(){
      return{
         'id':id,
         'category':category,
         'name': name,
         'description':description,
         'unitPrice':unitPrice,
         'unit':unit,
         'image':image
      };
   }

}