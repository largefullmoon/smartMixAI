import 'package:flutter/material.dart';
import 'package:sample/utils.dart';

class DrinkCategory extends StatelessWidget {
  final String title;
  final String emoji;

  const DrinkCategory({
    super.key,
    required this.title,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: hexToColor("#EFD9CB"),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/$emoji.png', // Placeholder for drink category image
            height: 50,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
