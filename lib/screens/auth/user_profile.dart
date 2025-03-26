import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sample/common/widgets/appbar.dart';
import 'package:sample/screens/auths/register.dart';
import 'package:sample/styles.dart';
import 'package:sample/utils.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/bg.png', // Replace with your image asset
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black
                .withValues(alpha: .3), // Dark overlay for better contrast
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getAppBar("USER PROFILE"),
                   SizedBox(height: 40,),
                  _getTopContainer(),
                  SizedBox(height: 40,),
                  Text("HISTORY OF COCKTAILS", style: CustomTextStyle.text_600(fontSize: 18),),
                  _getIndividualCard(),
                  _getIndividualCard(),
                  _getIndividualCard(),
                  _getIndividualCard(),
                   SizedBox(height: 20,),
                        _buildButton("SHARE YOUR PREFERENCE", hexToColor("#C58346"), Colors.white,
                      fullWidth: true),
                      SizedBox(height: 10,),
                            _buildButton("CHANGE YOUR PREFERENCE", Colors.black, Colors.white,
                      fullWidth: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTopContainer() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: hexToColor("#EBCCB9"),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: hexToColor("#C58346"))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "TASTE PREFERNCES",
            style: CustomTextStyle.text_600(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SUGAR : 8",
                  style: CustomTextStyle.text_600(fontSize: 16),
                ),
                SizedBox(
                  width: 8,
                ),
                getVerticalDivider(hexToColor("#CC9879")),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "ACID : 7 ",
                  style: CustomTextStyle.text_600(fontSize: 16),
                ),
                SizedBox(
                  width: 8,
                ),
                getVerticalDivider(hexToColor("#CC9879")),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "AMER : 5",
                  style: CustomTextStyle.text_600(fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getIndividualCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: hexToColor("#EBCCB9"),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Image.asset(
                  'assets/mocktail.png',
                  height: 80,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "MIJITO",
                            style: CustomTextStyle.text_600(fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 10,
                              child: Icon(Icons.favorite,color: hexToColor("#D6253F"),
                              size: 15,),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: ReadMoreText(
                          text :"lorema sdfasf af asfa sfa sfa sf asf asf as f asf as f asf as f asfas f asf as f saf a sf asf as fa sf asf asf as f sa"),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: getButton(
                            "REVIEW",
                            hexToColor("#C58346"),
                            Colors.white,
                            width: 100,
                            height: 21
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton(String label, Color bgColor, Color textColor,
      {bool fullWidth = false}) {
    return SizedBox(
      width: fullWidth ? double.infinity : 150,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {},
        child: Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}


class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLength;

  const ReadMoreText({Key? key, required this.text, this.maxLength = 90})
      : super(key: key);

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool shouldTruncate = widget.text.length > widget.maxLength;
    String displayText =
        (shouldTruncate && !isExpanded) ? '${widget.text.substring(0, widget.maxLength)}...' : widget.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style: TextStyle(fontSize: 9),
          maxLines: isExpanded ? null : 2,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (shouldTruncate) // Show 'Read more' only if truncation is needed
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Read less' : 'Read more',
              style: const TextStyle(color: Colors.blue,fontSize: 9),
            ),
          ),
      ],
    );
  }
}

