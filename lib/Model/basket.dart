class Basket{
  int id;
  String name;
  String unit;
  double unitPrice;
  int quantity;
  String image;
   Basket({this.id, this.name, this.unit, this.quantity, this.unitPrice, this.image});

  Map<String, dynamic> OrderRecord(){
    return{
      'id':id,
      'name':name,
      'unit':unit,
      'unitPrice':unitPrice,
      'quantity':quantity,
      'image':image
    };
  }

}