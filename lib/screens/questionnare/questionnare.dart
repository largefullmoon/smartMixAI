import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/common/widgets/appbar.dart';
import 'package:sample/common/widgets/indicator.dart';
import 'package:sample/screens/questionnare/controller.dart';
import 'package:sample/styles.dart';
import 'package:sample/utils.dart';
import 'package:sample/utils/overlay.dart';

class TastePreferenceScreen extends StatefulWidget {
  final String from;
  const TastePreferenceScreen({super.key, required this.from});

  @override
  _TastePreferenceScreenState createState() => _TastePreferenceScreenState();
}

class _TastePreferenceScreenState extends State<TastePreferenceScreen> {
  int _selectedCategory = 0;

  set selectedCategory(int value) {
    if (value >= 0 && value < categories.length) {
      _selectedCategory = value;
    }
  }

  int get selectedCategory => _selectedCategory;

  Map<int, int> selectedValues = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0
  }; // Default selections

  final List<String> categories = ["SWEET", "SOUR", "SPICY", "BITTER", "SALTY"];

  double _sliderValue = 5.0;

  final QuestionnaireController _controller =
      Get.find<QuestionnaireController>();

  Future<void> _saveScore() async {
    await showOverlay(asyncFunction: () async {
      await _controller.saveScore(selectedValues);
      // Get.toNamed('/dashboard');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getScore().then((value) {
      if (value != null) {
        Map<int, int> scores = (jsonDecode(value) as Map<String, dynamic>)
            .map((key, value) => MapEntry(int.parse(key), value as int));
        setState(() {
          selectedValues = scores;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg.png',
            fit: BoxFit.fill,
          ),
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getAppBar("Questionnaire"),
                  // Taste Tabs
                  _getTopSliderView(),

                  SizedBox(height: 20),

                  // Question Text
                  Text(
                    "On A Scale Of 1 To 10,\nHow Much Do You Like Sweet Drinks?",
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.text_500(fontSize: 16),
                  ),

                  SizedBox(height: 20),

                  // Illustration (Placeholder for Image)
                  Image.asset('assets/questionnare.png'),

                  SizedBox(height: 30),

                  // Slider Row
                  _getSlider(),
                  SizedBox(height: 30),
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButton("BACK", Colors.white, Colors.black,
                          onPressed: () {
                        setState(() {
                          selectedCategory -= 1;
                        });
                      }),
                      _buildButton("NEXT", hexToColor("#C58346"), Colors.white,
                          onPressed: () {
                        setState(() {
                          selectedCategory += 1;
                        });
                      }),
                    ],
                  ),

                  SizedBox(height: 20),
                  (widget.from == 'settings')
                      ? _buildButton("SAVE", Colors.black, Colors.white,
                          fullWidth: true, onPressed: () async {
                          await _saveScore();
                          Get.back();
                        })
                      :
                  _buildButton("MENU BAR", Colors.black, Colors.white,
                          fullWidth: true, onPressed: () async {
                          _saveScore().whenComplete(() {
                            Get.offAllNamed('/dashboard');
                          });
                        }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTopSliderView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Category Tabs
        Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.brown.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: 25,
              child: ListView.separated(
                separatorBuilder: (context, index) => VerticalDivider(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedCategory == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                    child: Container(
                      // margin: EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? hexToColor("#C58346")
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isSelected ? Colors.black : Colors.black54,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )),

        SizedBox(height: 20),

        // Selected Value Labels

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: selectedValues.keys.map((number) {
                    var value = selectedValues[number];
                    var isCurrent = number == selectedCategory + 1;
                    return CircleAvatar(
                      radius: 11,
                      backgroundColor:
                          isCurrent ? Colors.black : hexToColor("#C58346"),
                      child: Text(
                        value.toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Stack(
                children: [
                  // Slider Track
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 4,
                    // width: 250,
                    color: Colors.grey.shade400,
                  ),
                  // Fixed Dots (Selectable)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: selectedValues.keys.map((number) {
                      bool isSelected = selectedValues[number] != 0;
                      return Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          border: Border.all(color: Colors.white, width: 3),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: CircleAvatar(
                          radius: 8,
                          backgroundColor:
                              isSelected ? hexToColor("#EDD7C9") : Colors.black,
                        )),
                      );
                    }).toList(),
                  ),
                ],
              ),
              // Index
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: selectedValues.keys.map((number) {
                    return CircleAvatar(
                      radius: 12,
                      backgroundColor: hexToColor("#C58346"),
                      child: Text(
                        number.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getSlider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 2.0, // Thin track thickness
        activeTrackColor: hexToColor("#C58346"),
        inactiveTrackColor: hexToColor("#C58346"),
        thumbColor: hexToColor("#EDD7C9"),
        overlayColor: Colors.blue.withOpacity(0.2),
        thumbShape: RoundSliderThumbWithBorder(
            thumbRadius: 15.0, borderColor: Colors.black),
      ),
      child: Slider(
        value: _sliderValue,
        min: 1,
        max: 10,
        onChanged: (value) {
          setState(() {
            selectedValues[selectedCategory + 1] = (value).toInt();

            _sliderValue = value;
          });
        },
      ),
    );
  }

  Widget _buildButton(String label, Color bgColor, Color textColor,
      {bool fullWidth = false, VoidCallback? onPressed}) {
    return SizedBox(
      width: fullWidth ? double.infinity : 150,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _sliderValue = 5.0;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 2.0, // Thin track thickness
        activeTrackColor: hexToColor("#C58346"),
        inactiveTrackColor: hexToColor("#C58346"),
        thumbColor: hexToColor("#EDD7C9"),
        overlayColor: Colors.blue.withOpacity(0.2),
        thumbShape: RoundSliderThumbWithBorder(
            thumbRadius: 15.0, borderColor: Colors.black),
      ),
      child: Slider(
        value: _sliderValue,
        min: 0,
        max: 10,
        onChanged: (value) {
          setState(() {
            _sliderValue = value;
          });
        },
      ),
    );
  }
}

class RoundSliderThumbWithBorder extends SliderComponentShape {
  final double thumbRadius;
  final Color borderColor;
  final double borderThickness;

  RoundSliderThumbWithBorder(
      {this.thumbRadius = 12.0,
      this.borderColor = Colors.blue,
      this.borderThickness = 4.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Outer border circle
    Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThickness;

    // Inner filled circle
    Paint fillPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    // Draw thumb
    canvas.drawCircle(center, thumbRadius, fillPaint);
    canvas.drawCircle(center, thumbRadius, borderPaint);

    // Draw value inside thumb
    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      text: (value * 10).round().toString(),
    );

    TextPainter textPainter = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    Offset textOffset =
        center - Offset(textPainter.width / 2, textPainter.height / 2);
    textPainter.paint(canvas, textOffset);
  }
}
