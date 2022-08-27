//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:music_app/models/music_model.dart';
//
// class RTDBService{
//   //giving value
//   static final database = FirebaseDatabase.instance.ref();
//
//   //store
//   static Future<Stream<DatabaseEvent>>storeProduct(Music music)async{
//     String? key = database.child("products").push().key;
//     music.productKey = key!;
//     await database.child("products").child(product.productKey).set(product.toJson());
//     return database.onChildAdded;
//   }
//
//   //load
//   static Future<List<Music>>loadProduct(String id)async{
//     List<Music>items =[];
//     Query query = database.child("products").orderByChild("userId").equalTo(id);
//     var snapShot = await query.once();
//     var result = snapShot.snapshot.children;
//     for(DataSnapshot item in result){
//       if(item.value != null){
//         items.add(Music.fromJson(Map<String, dynamic>.from(item.value as Map)));
//       }
//     }
//     print(items.map((e) => e.toJson()));
//     return items;
//   }
//
//   static Future<void>deleteProduct(String productKey)async{
//     await database.child("products").child(productKey).remove();
//   }
//
//   static Future<Stream<DatabaseEvent>>updateProduct(Music music)async{
//     await database.child("products").child(product.productKey).set(product.toJson());
//     return database.onChildAdded;
//   }
//
//
//
// }