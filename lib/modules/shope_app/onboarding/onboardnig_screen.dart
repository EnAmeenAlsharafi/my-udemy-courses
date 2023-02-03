// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:my_udemy_apps/modules/shope_app/shop_login/shop_login_screen.dart';
import 'package:my_udemy_apps/shared/component/component.dart';
import 'package:my_udemy_apps/shared/network/local/cash_helper.dart';
import 'package:my_udemy_apps/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  String? title;
  String? image;
  String? body;
  BoardingModel({this.title, this.image, this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var BoardControlar = PageController();
  bool isLast = false;

  List<BoardingModel> boardingModels = [
    BoardingModel(
      title: 'Boarding Title 1',
      image: 'assets/onboard_1.jpg',
      body: 'Lorem ipsum dolor sit amet',
    ),
    BoardingModel(
      title: 'Boarding Title 2',
      image: 'assets/onboard_1.jpg',
      body: 'Lorem ipsum dolor sit amet',
    ),
    BoardingModel(
      title: 'Boarding Title 3',
      image: 'assets/onboard_1.jpg',
      body: 'Lorem ipsum dolor sit amet',
    ),
  ];
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinsh(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defualtFunction(
              text: 'Skip',
              function: () {
                submit();
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boardingModels.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: BoardControlar,
                itemBuilder: (context, index) =>
                    BuildingBoardingItem(boardingModels[index]),
                itemCount: boardingModels.length,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: BoardControlar,
                  count: boardingModels.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      spacing: 5.0,
                      activeDotColor: defaultColor,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      expansionFactor: 3.0),
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        BoardControlar.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildingBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          SizedBox(height: 15.0),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 15.0),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 30),
          ),
        ],
      );
}
