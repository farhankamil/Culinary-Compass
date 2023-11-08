import 'package:culinary_compass/data/presentation/widget/restaurant_card.dart';
import 'package:flutter/material.dart';

import 'package:culinary_compass/data/local_datasources/restaurants_datasources.dart';
import 'package:culinary_compass/data/models/restaurants_model.dart';

import '../../common/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RestaurantsModel? restaurantsModel;

  @override
  void initState() {
    super.initState();
    fetchRestaurantModel().then((value) {
      setState(() {
        restaurantsModel = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Culinary Compass'),
        backgroundColor: primaryColor,
      ),
      body: restaurantsModel != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                final restaurant = restaurantsModel!.restaurants[index];
                if (index % 2 == 0) {
                  return RestaurantCardKiri(
                    restaurant: restaurant,
                  );
                } else {
                  return RestaurantCardKanan(
                    restaurant,
                  );
                }
              },
              itemCount: restaurantsModel!.restaurants.length,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
