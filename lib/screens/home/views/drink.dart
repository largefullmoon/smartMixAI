import 'package:flutter/material.dart';
import 'package:sample/models/response/drink.dart';
import 'package:sample/screens/home/controller.dart';
import 'package:sample/utils.dart';

class DrinkCard extends StatelessWidget {
  final UiDrink drink;
  final String url;
  final HomeController controller;
  const DrinkCard({
    super.key,
    required this.drink,
    required this.controller,
    this.url = 'image-7.png',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: hexToColor("#EBCCB9"),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  drink.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              InkWell(
                onTap: drink.favorite
                    ? null
                    : () async {
                        await controller.addToFavorite(drink.id);
                      },
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.favorite,
                    color: drink.favorite ? Colors.red : Colors.grey,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: drink.description,
              style: TextStyle(fontSize: 12, color: Colors.black),
              children: [
                TextSpan(
                  text: 'Read More',
                  style: TextStyle(color: hexToColor("#C58346")),
                ),
              ],
            ),
          ),
          Spacer(),
          Center(
            child: Image.network(
              drink.url,
              height: 100,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 70,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: hexToColor("#C58346"),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'LIKE',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 70,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'DISLIKE',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
