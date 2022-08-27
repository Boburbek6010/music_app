import 'package:shared_preferences/shared_preferences.dart';

enum StorageKey{uid}

class PrefService {

//store data
  static Future<bool>savaData(String uid)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(StorageKey.uid.name, uid);
  }


//load data
  static Future<String?>loadData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(StorageKey.uid.name);
  }


//remove data
  static Future<bool>removeData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove(StorageKey.uid.name);
  }


}