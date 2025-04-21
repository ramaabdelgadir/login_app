import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_app/external/app_data.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SingleStoreRepo {
  
  static Future<Map<String,dynamic>> addStoreToFavo(int storeid) async{
      final client = http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    try {
      var response = await client.post(
        Uri.parse('${AppData.SERVER_URL}/stores/addtofavo/'),
        headers: {"Content-Type": "application/json","Authorization":token!},
        body: json.encode({"storeid": storeid})
       );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        data["status"] = true;
        return data;
      } else {
        data["status"] = false;
        return data;
      }
    } catch (e) {
      return {'status': false, "error": e};
    }

  }

  static Future<Map<String,dynamic>> removeStoreFromFavo(int storeid) async{
      final client = http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    try {
      var response = await client.post(
        Uri.parse('${AppData.SERVER_URL}/stores/removefromfavo/'),
        headers: {"Content-Type": "application/json","Authorization":token!},
        body: json.encode({"storeid":storeid})
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        data["status"] = true;
        return data;
      } else {
        data["status"] = false;
        return data;
      }
    } catch (e) {
      return {'status': false, "error": e};
    }

  }

}