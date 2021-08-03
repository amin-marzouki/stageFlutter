import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_laravel/models/promotion.dart';

class Fetch {
  Dio _client;

  Fetch(this._client);

void fetchAllPromotion() async {
    try {
      final response = await _client.get('/promotion');
      // It's better to return a Model class instead but this is
      // only for example purposes only
      final body = json.decode(response.toString());
      final feeds = body['result'];
      var items = [];
      feeds.forEach((item) {
        items.add(Promotion(item["title"], item["description"], item["type"],
            item["partenaire"]));
      });
      setState(() {
          dataStr = data.toString();
          _items = items;
        });
      }
    });

      
    } on DioError catch (ex) {
      // Assuming there will be an errorMessage property in the JSON object
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw new Exception(errorMessage);
    }
  }
}

//new ListView.builder(itemCount: _items.length, itemBuilder: itemView)