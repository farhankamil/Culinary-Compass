import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/restaurants_model.dart';

Future<RestaurantsModel> fetchRestaurantModel() async {
  final jsonString =
      await rootBundle.loadString('assets/local_restaurant.json');
  final json = jsonDecode(jsonString);
  final restaurantsModel = RestaurantsModel.fromJson(json);
  return restaurantsModel;
}
