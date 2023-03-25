

import 'package:dio/dio.dart';
import 'package:exam_march/models/card_model.dart';


import '../core/api/api.dart';
import '../core/config/dio_config.dart';
import 'log_service.dart';
class CardService {
  static final CardService _inheritance = CardService._init();

  static CardService get inheritance => _inheritance;

  CardService._init();

  static Future<List<CardModel>?> getCard() async {

    try {
      Response res =
      await DioConfig.inheritance.createRequest().get(Urls.getCards);
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200) {
        List<CardModel> userList = [];
        for (var e in (res.data as List)) {
          userList.add(CardModel.fromJson(e));
        }

        return userList;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
    }
    return null;
  }


  static Future<bool> addCard(CardModel newCard) async {
    try {
      Response res = await DioConfig.inheritance
          .createRequest()
          .post(Urls.addCard,
          data: {
            "name": newCard.name,
            "cardnumber":newCard.cardnumber,
            "date":newCard.date,
            "balance":newCard.balance

          });
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
        return false;
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }
/*
  static Future<bool> editUser(CardModel newUser) async {
    try {
      Response res = await DioConfig.inheritance
          .createRequest()
          .put(Urls.updateUser + newUser.id.toString(), data: {
        "userId": newUser.userId,
        "title": newUser.title,
        "body": newUser.body
      });
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
        return false;
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }
*/

  static Future<bool> deleteCard(String id) async {
    try {
      Response res = await DioConfig.inheritance
          .createRequest()
          .delete(Urls.deleteCard + id);
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
        return false;
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }
}