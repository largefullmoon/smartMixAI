import 'package:flutter/material.dart';
import 'package:sample/utils.dart';

class DrinkCard extends StatelessWidget {
  final String name;
  final String url;

  const DrinkCard({super.key, required this.name, this.url = 'image-7.png'});

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
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 15,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Lorem Ipsum is simply and typesetting ',
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
            child: Image.asset(
              'assets/$url',
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
