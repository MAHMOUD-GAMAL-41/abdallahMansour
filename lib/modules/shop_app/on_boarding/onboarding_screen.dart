import 'package:ex2/modules/shop_app/login/login_screen.dart';
import 'package:ex2/shared/components/news_components.dart';
import 'package:ex2/shared/components/shopapp_components.dart';
import 'package:ex2/shared/network/local/cache_helper.dart';
import 'package:ex2/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
   final String image, title, body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var BoardingController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/q1.jpg',
        title: 'On Boarding Title 1',
        body: 'On Boarding Body 1'),
    BoardingModel(
        image: 'assets/images/q2.jpg',
        title: 'On Boarding Title 2',
        body: 'On Boarding Body 2'),
    BoardingModel(
        image: 'assets/images/q3.jpg',
        title: 'On Boarding Title 3',
        body: 'On Boarding Body 3'),
  ];
  bool isLast = false;
 void submit(){
   CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
     if(value) {
       navigateAndFinish(context, ShopLoginScreen());

     }
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(function: submit, text: 'Skip'),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print('Last');
                  } else {
                    setState(() {
                      isLast = false;
                    });
                    print('Not Last');
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: BoardingController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: BoardingController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      BoardingController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
}
