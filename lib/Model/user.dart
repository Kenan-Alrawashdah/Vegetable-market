
 class User {
   int id ;
   String firstName;
   String lastName;
   String email;
   String password;

   User({this.id, this.firstName, this.lastName, this.email, this.password});

   Map<String, dynamic> userRecord(){
     return{
       'id': id,
       'lastName':lastName,
       'firstName':firstName,
       'email':email,
       'password':password
     };
   }


 }