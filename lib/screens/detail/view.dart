import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/common/widgets/appbar.dart';
import 'package:sample/screens/detail/controller.dart';
import 'package:sample/styles.dart';
import 'package:sample/utils.dart';

class DrinkDetailScreen extends GetView<DrinkDetailController> {
  final String id;
  final String name;
  const DrinkDetailScreen({Key? key, required this.id, required this.name})
      : super(
          key: key,
        );

  // void onInit() {
  //   controller.fetchProduct(id);
  // }

  @override
  Widget build(BuildContext context) {
    controller.fetchProduct(id);
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
          GetBuilder<DrinkDetailController>(
            id: 'detail',
            builder: (DrinkDetailController controller) {
              if (controller.detail == null) return SizedBox();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  getAppBar(name),
                  // Top Image Card
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Image.asset('assets/mojito-bg.png'),
                          Center(
                            child: Image.asset('assets/mojito.png'),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                    child: Icon(
                                      Icons.favorite,
                                      color: hexToColor("#D6253F"),
                                      size: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2),
                                  child: CircleAvatar(
                                    backgroundColor: hexToColor("#C58346"),
                                    radius: 15,
                                    child: Icon(
                                      Icons.thumb_down_sharp,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Ingredients & Instructions Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: hexToColor("#EBCCB9"),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: hexToColor("#C58346"))),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Ingredients
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text("INGREDIENTS",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),

                                      ...(controller.detail!.incredients).map(
                                          (e) =>
                                              ingredientItem(e.first, e.second))
                                      // ingredientItem("50ml", "50ml Rhum"),
                                      // ingredientItem(
                                      //     "20ml", "20ml Jus de citron vert"),
                                      // ingredientItem("men", "Menthe fraîche"),
                                    ],
                                  ),
                                ),
                                getVerticalDivider(hexToColor("#D8A484"),
                                    height: 100),
                                // Instructions
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text("INSTRUCTIONS",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      ...(controller.detail!.instructions).map(
                                          (e) => instructionItem(
                                              e.first, e.second))
                                      // instructionItem("mel", "Mélanger."),
                                      // instructionItem("ser", "Servir frais."),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  // Brief History Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "BRIEF HISTORY:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                  controller.detail!.rating,
                                  (index) => const Icon(Icons.star,
                                      color: Colors.black, size: 18)),
                            ),
                            const Icon(Icons.star_border,
                                color: Colors.black, size: 18),
                            const SizedBox(width: 5),
                            Text(
                              "${controller.detail!.reviews} reviews",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 9,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            controller.detail!.description,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildButton(
                            "LEARN MORE", hexToColor("#C58346"), Colors.white)
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, Color bgColor, Color textColor,
      {bool fullWidth = false}) {
    return SizedBox(
      width: double.infinity,
      height: 40,
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

  Widget ingredientItem(String image, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 10,
                child: Image.asset('assets/$image.png'),
              ),
              const SizedBox(width: 5),
              Text(
                text,
                style: CustomTextStyle.text_400(fontSize: 10),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
                child: CircleAvatar(
                  backgroundColor: hexToColor("#C58346"),
                  radius: 8,
                  child: Icon(
                    Icons.thumb_down_sharp,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 8,
                  child: Icon(
                    Icons.favorite,
                    color: hexToColor("#D6253F"),
                    size: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget instructionItem(String image, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 10,
            child: Image.asset('assets/$image.png'),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: CustomTextStyle.text_400(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
