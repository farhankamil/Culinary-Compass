import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:culinary_compass/data/models/restaurants_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../common/constants.dart';

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);
  final Restaurant restaurant;

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    final heightImage = MediaQuery.of(context).size.height * 0.6;
    final widthImage = MediaQuery.of(context).size.width;
    final menus = widget.restaurant.menus.foods;
    final drinks = widget.restaurant.menus.drinks;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: heightImage,
            width: widthImage,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.restaurant.pictureId,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              left: 25.0,
            ),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 1.0,
            minChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                width: widthImage,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              height: 4,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        Text(
                          widget.restaurant.name,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: bold,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RatingBarIndicator(
                              rating: widget.restaurant.rating,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemSize: 18,
                            ),
                            Text(
                              ' | ${widget.restaurant.rating}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: const Color(0xFF616161)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 18,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.restaurant.city,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: const Color(0xFF616161)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.restaurant.description,
                          textAlign: TextAlign.justify,
                          maxLines: readMore ? 50 : 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              readMore = !readMore;
                            });
                          },
                          child: Text(
                            readMore ? "Read less" : "Read more",
                            style: const TextStyle(
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("Makanan:"),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var menu in menus)
                                Container(
                                  width: 120,
                                  margin: const EdgeInsets.only(
                                    right: 6,
                                    left: 6,
                                    top: 15,
                                    bottom: 15,
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5,
                                        offset: Offset(1, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/ic_food.png',
                                        fit: BoxFit.contain,
                                        height: 80,
                                        width: 60,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        menu.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("Minuman:"),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var drink in drinks)
                                Container(
                                  width: 120,
                                  margin: const EdgeInsets.only(
                                    right: 6,
                                    left: 6,
                                    top: 15,
                                    bottom: 15,
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5,
                                        offset: Offset(1, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/ic_juice.png',
                                        fit: BoxFit.contain,
                                        height: 80,
                                        width: 60,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        drink.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
