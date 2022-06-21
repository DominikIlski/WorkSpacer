import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;

typedef JSON = Map<String, dynamic>;

const dummyBody = <String, dynamic>{};

class Proxy {
  static Future<JSON> data(String ctdName,
      {String method = 'GET', JSON body = dummyBody}) async {
    var callable = FirebaseFunctions.instance.httpsCallable('proxy');
    try {
      final result = await callable.call<JSON>({
        'route': ctdName,
        'method': method,
        if (body.isNotEmpty) 'body': body
      });
      print(result);
      return result.data;
    } catch (e) {
      throw e;
    }
  }

  static Future<JSON> isDateAvailable(
    bool isDesk,
    String startDate,
    int duration,
    int workspaceId
  ) async {
    var callable = FirebaseFunctions.instance.httpsCallable('isDateAvailable');
    try {
      final result = await callable.call<JSON>(
          {'isDesk': isDesk, 'date': startDate, 'duration': duration, 'workspaceId': workspaceId});
      print(result);
      return result.data;
    } catch (e) {
      throw e;
    }
  }

  static Future<JSON> notifyUser(
    bool isDesk,
    int reservationId,
  ) async {
    var callable = FirebaseFunctions.instance.httpsCallable('notifyUser');
    try {
      final result = await callable.call<JSON>({
        'isDesk': isDesk,
        'reservationId': reservationId
      });
      print(result);
      return result.data;
    } catch (e) {
      throw e;
    }
  }
}
