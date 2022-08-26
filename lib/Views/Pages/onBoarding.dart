import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:provider/provider.dart';

import '../../Data/Providers/MainRouterDelegate.dart';
import '../../Utils/AppColors.dart';

// onBoarding page
class onBoarding extends StatefulWidget {
  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  // Defining an int that will keep track of the index the program is in
  int currentPage = 0;
  // Defining a pagecontroller
  PageController pageController = PageController();

  // Defining a List of widgets that has the onBoarding pages
  late List<Widget> pages = [
    onBorading_page1(1),
    onBorading_page2(0),
    onBorading_page3(0)
  ];

  // Animate closing the page
  void popout() {
    setState(() {
      updateList(pages, 0, 0, 0);
    });
  }

  // Animate opening the page
  void popin() {
    setState(() {
      if (currentPage == 0) {
        updateList(pages, 1, 0, 0);
      }
      if (currentPage == 1) {
        updateList(pages, 0, 1, 0);
      }
      if (currentPage == 2) {
        updateList(pages, 0, 0, 1);
      }
    });
  }

  // wait 200 milliseconds and display the loading animation
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 300), () {
      popin();
    });
  }

  @override
  Widget build(BuildContext context) {
    int animationDuration = 700;
    return Scaffold(
      body: Container(
        // Displaying a stack
        child: Stack(
          children: <Widget>[
            SvgPicture.asset("assets/analytics.svg"),
            // Displaying an object at the bottom right of the page in the background
            AnimatedPositioned(
                duration: Duration(milliseconds: animationDuration),
                curve: Curves.ease,
                bottom: 0,
                right: 0,

                // If it's the second page if the screen's width is  more than its height make it's height and width equals to the width of the screen multiplied by 1.6 else the height multiplied by 1.6(the width and the height must be the same to make sure when it animates it lokks like a circle getting bigger)
                // If it's the last page increase it's width make the width 136 else make it 329
                // If it's not the second page make its height 136
                width: currentPage == 1
                    ? MediaQuery.of(context).size.width >
                            MediaQuery.of(context).size.height
                        ? MediaQuery.of(context).size.width * 1.6
                        : MediaQuery.of(context).size.height * 1.6
                    : currentPage != pages.length - 1
                        ? 68
                        : 104,
                height: currentPage == 1
                    ? MediaQuery.of(context).size.width >
                            MediaQuery.of(context).size.height
                        ? MediaQuery.of(context).size.width * 1.6
                        : MediaQuery.of(context).size.height * 1.6
                    : currentPage != pages.length - 1
                        ? 68
                        : 53,
                child: Transform.translate(
                  // if it's not the last page move it by an offset(68, 68) else it doesn't change its position
                  offset: currentPage != pages.length - 1
                      ? Offset(68, 68)
                      : Offset(0, 0),
                  child:
                      // Displaying the quarter circle
                      Container(
                          decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: currentPage != pages.length - 1
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(
                                MediaQuery.of(context).size.height),
                            topLeft: Radius.circular(
                                MediaQuery.of(context).size.height),
                            topRight: Radius.circular(
                                MediaQuery.of(context).size.height))
                        : BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        AppColors.primaryColor,
                        Color(0xff990000)
                      ],
                    ),
                  )),
                )),
            // Displaying the pages
            Positioned(
              child: Container(
                color: Colors.transparent,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  itemCount: pages.length,
                  // physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      // updating the current page variable
                      currentPage = index;
                    });
                    // Animating the current page
                    popin();
                  },
                  itemBuilder: (context, int index) {
                    return pages[index];
                  },
                ),
              ),
            ),
            // Displaying a row of buttons at the bottom of the page
            Positioned(
              bottom: 0,
              // Giving it full width
              width: MediaQuery.of(context).size.width,
              child: Container(
                // Giving it some margin on the right and left sides
                margin: EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                    // Making its contents fill all the space in it
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Displaying a button
                      GestureDetector(
                        // If it's not the the last page make display "skip" and when it's clicked call the popout function, else remove the text and make it do nothing
                        child: currentPage != pages.length - 1
                            ? Text("Skip",
                                style: TextStyle(
                                    color: currentPage == 1
                                        ? Colors.white
                                        : AppColors.primaryColor))
                            : Text(""),
                        onTap: currentPage != pages.length - 1
                            ? () {
                                popout();
                              }
                            : () {},
                      ),
                      Row(
                        children:
                            List<Widget>.generate(pages.length, (int index) {
                          return AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              width: 7,
                              height: (index == currentPage) ? 30 : 12,
                              margin: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: currentPage != 1
                                    ? (index == currentPage)
                                        ? AppColors.primaryColor
                                        : AppColors.primaryColor
                                            .withOpacity(0.5)
                                    : (index == currentPage)
                                        ? Color(0xffffffff)
                                        : Color(0xffffffff).withOpacity(0.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: (index == currentPage)
                                        ? currentPage == 1
                                            ? Colors.white.withOpacity(0.25)
                                            : AppColors.primaryColor
                                                .withOpacity(0.25)
                                        : Colors.transparent,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                  )
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (index != currentPage) {
                                    popout();
                                    setState(() {
                                      currentPage = index;
                                    });
                                    Timer(
                                        Duration(
                                            milliseconds: animationDuration),
                                        () {
                                      pageController.animateToPage(index,
                                          duration: Duration(
                                              milliseconds:
                                                  (animationDuration / 10)
                                                      .toInt()),
                                          curve: Curves.linear);
                                    });
                                  }

                                  // });
                                },
                              ));
                        }),
                      ),
                      SizedBox(
                        width: 1,
                      )
                    ]),
              ),
            ),
            // Displaying a button at the bottom right of the page
            AnimatedPositioned(
              duration: Duration(milliseconds: (animationDuration / 2).toInt()),
              bottom: 0,
              right: 0,
              // if it's not the last page make its width 68 else make it 225
              width: currentPage != pages.length - 1 ? 68 : 104,
              height: currentPage != pages.length - 1 ? 68 : 53,
              // if it's not the last page move by an offset of (68, 68) and if it's clicked go to the next page, else move it by (215, 83) and call the popout function
              child: Transform.translate(
                offset: currentPage != pages.length - 1
                    ? Offset(0, 0)
                    : Offset(0, 0),
                child: GestureDetector(
                  onTap: () {
                    if (currentPage != pages.length - 1) {
                      popout();
                      setState(() {
                        currentPage++;
                      });
                      Timer(Duration(milliseconds: animationDuration), () {
                        pageController.nextPage(
                            duration: Duration(
                                milliseconds: (animationDuration / 2).toInt()),
                            curve: Curves.linear);
                      });
                    } else {
                      popout();
                    }
                    // });
                  },
                  // Making the button a circle and aligning it's children at the top left and giving it some padding
                  child: AnimatedContainer(
                    duration:
                        Duration(milliseconds: (animationDuration / 2).toInt()),
                    padding: EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        // If it's not the second page make its color red else make it white
                        color: currentPage != 1
                            ? AppColors.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                currentPage != pages.length - 1 ? 200 : 16))),
                    child: Transform.translate(
                      offset: currentPage != pages.length - 1
                          ? Offset(6, 6)
                          : Offset(0, 0),
                      child: Positioned(
                        // if it's not the last page make it's child an icon and make it red if it's the second page if it isn't make it white
                        // Else, it's last page make it's child a text "start now"
                        child: currentPage != pages.length - 1
                            ? Icon(Icons.navigate_next_rounded,
                                color: currentPage != 1
                                    ? Colors.white
                                    : AppColors.primaryColor,
                                size: 42)
                            : Text("GET STARTED!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Display the logo in a hero widget at the top left of the screen and make it white if it's the second page
            Positioned(
                top: 8,
                left: 14,
                child: Hero(
                  tag: 'logo',
                  child: Image.asset("assets/logo.png",
                      width: 31,
                      height: 49,
                      color: currentPage == 1
                          ? Colors.white
                          : AppColors.primaryColor),
                )),
          ],
        ),
      ),
    );
  }
}

class onBorading_page1 extends StatefulWidget {
  double factor;

  onBorading_page1(this.factor);

  @override
  State<onBorading_page1> createState() => _onBorading_pageState1();
}

class _onBorading_pageState1 extends State<onBorading_page1> {
  double opacity = 0;
  int animationDuration = 700;
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(
            milliseconds: widget.factor == 1
                ? animationDuration
                : (animationDuration / 2).toInt()), () {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Displaying a stack
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Centering the image
            Container(
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: Duration(
                    milliseconds: widget.factor == 1
                        ? animationDuration
                        : (animationDuration / 2).toInt()),
                curve: widget.factor == 1 ? Curves.linear : Curves.easeOutCirc,
                alignment: Alignment.center,
                // Giving it a top margin in a responsive way
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (15 / 100)),
                // Giving it full width
                width: MediaQuery.of(context).size.width * widget.factor,
                child: Container(
                    // If the seed isn't 2 display the image only, if it is, display a stack that has the ellipse image and over it the image
                    child: SvgPicture.asset("assets/onBoarding/nerd.svg")),
              ),
            ),
            // To make the stack take full width and height
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            // Displaying a big circle border and changing its position according to the seed
            circle(
                1,
                widget.factor,
                0,
                "0",
                "null",
                190,
                Offset(27, -87),
                Colors.transparent,
                Colors.transparent,
                AppColors.primaryColor,
                4,
                MediaQuery.of(context).size.width),
            // Displaying a small filled circle and changing its position according to the seed
            circle(
                1,
                widget.factor,
                103,
                "null",
                "53",
                30,
                Offset(0, 0),
                AppColors.primaryColor,
                Colors.transparent,
                Colors.transparent,
                0,
                MediaQuery.of(context).size.width),
            // Displaying a small circle border and changing its position according to the seed and giving it shadow and fill color if the seed is 1
            circle(
                1,
                widget.factor,
                MediaQuery.of(context).size.height * 0.6325,
                "32",
                "null",
                30,
                Offset(0, 0),
                Colors.white,
                AppColors.primaryColor.withOpacity(0.25),
                AppColors.primaryColor,
                3,
                MediaQuery.of(context).size.width),
            // Displaying a different circle that has text in it
            AnimatedPositioned(
                duration: Duration(
                    milliseconds: widget.factor == 1
                        ? animationDuration
                        : (animationDuration / 2).toInt()),
                curve: widget.factor == 1 ? Curves.linear : Curves.easeOutCirc,
                // Positioning it in a way that makes it responsive
                top: MediaQuery.of(context).size.height * 0.61,
                left: -44,
                // Giving it full width and a height of 170
                width: MediaQuery.of(context).size.width * widget.factor,
                height: 170 * widget.factor,
                child:
                    // Displaying a stack that will have the circle and in top of it the text
                    Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(
                          milliseconds: widget.factor == 1
                              ? animationDuration
                              : (animationDuration / 2).toInt()),
                      curve: widget.factor == 1
                          ? Curves.linear
                          : Curves.easeOutCirc,
                      width: 190 * widget.factor,
                      height: 170 * widget.factor,
                      decoration: BoxDecoration(
                          // Giving it the standard red color if the seed isn't 2
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(250)),
                    ),
                    // Displaying a column and making it take the least size
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Displaying 2 animated containers with full width and giving it some margin and  making one for the title and the other for the text and making it black unless the seed is 2, it will be white
                        AnimatedContainer(
                            duration: Duration(
                                milliseconds: widget.factor == 1
                                    ? animationDuration
                                    : (animationDuration / 2).toInt()),
                            curve: widget.factor == 1
                                ? Curves.linear
                                : Curves.easeOutCirc,
                            width: double.infinity,
                            margin:
                                EdgeInsets.only(left: 59, bottom: 17, top: 36),
                            child: AnimatedTextKit(
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    'Join',
                                    textStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width <
                                                    337
                                                ? 27
                                                : 36,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white.withOpacity(1)),
                                    textAlign: TextAlign.start,
                                  )
                                ])),
                        AnimatedContainer(
                            duration: Duration(
                                milliseconds: widget.factor == 1
                                    ? animationDuration
                                    : (animationDuration / 2).toInt()),
                            curve: widget.factor == 1
                                ? Curves.linear
                                : Curves.easeOutCirc,
                            margin: EdgeInsets.only(left: 59),
                            width: double.infinity,
                            child: AnimatedTextKit(
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    'You can find the best suited team for you to join and make sure you will get the most befit from it',
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(1)),
                                    textAlign: TextAlign.start,
                                  )
                                ])),
                      ],
                    ),
                    // ),
                  ],
                )),
          ],
        ),
      ],
    );
  }
}

class onBorading_page2 extends StatefulWidget {
  double factor;

  onBorading_page2(this.factor);

  @override
  State<onBorading_page2> createState() => _onBorading_pageState2();
}

class _onBorading_pageState2 extends State<onBorading_page2> {
  double opacity = 0;
  int animationDuration = 700;
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(
            milliseconds: widget.factor == 1
                ? animationDuration
                : (animationDuration / 2).toInt()), () {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Displaying a stack
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Centering the image
            Container(
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: Duration(
                    milliseconds: widget.factor == 1
                        ? animationDuration
                        : (animationDuration / 2).toInt()),
                curve: widget.factor == 1 ? Curves.linear : Curves.easeOutCirc,
                alignment: Alignment.center,
                // Giving it a top margin in a responsive way
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (9.125 / 100)),
                // Giving it full width
                width: MediaQuery.of(context).size.width * widget.factor,
                child: Container(
                    // If the seed isn't 2 display the image only, if it is, display a stack that has the ellipse image and over it the image
                    child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                      SvgPicture.asset(
                        "assets/onBoarding/bg_ellipse.svg",
                        allowDrawingOutsideViewBox: true,

                        // width: MediaQuery.of(context).size.width,
                        // height: 423.31,
                      ),
                      SvgPicture.asset("assets/onBoarding/chat.svg"),
                    ])),
              ),
            ),
            // To make the stack take full width and height
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            // Displaying a different circle that has text in it
            AnimatedPositioned(
                duration: Duration(
                    milliseconds: widget.factor == 1
                        ? animationDuration
                        : (animationDuration / 2).toInt()),
                curve: widget.factor == 1 ? Curves.linear : Curves.easeOutCirc,
                // Positioning it in a way that makes it responsive
                top: MediaQuery.of(context).size.height * 0.61,
                left: -44,
                // Giving it full width and a height of 170
                width: MediaQuery.of(context).size.width * widget.factor,
                height: 170 * widget.factor,
                child:
                    // Displaying a stack that will have the circle and in top of it the text
                    Stack(
                  children: [
                    // Displaying a column and making it take the least size
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Displaying 2 animated containers with full width and giving it some margin and  making one for the title and the other for the text and making it black unless the seed is 2, it will be white
                        AnimatedContainer(
                            duration: Duration(
                                milliseconds: widget.factor == 1
                                    ? animationDuration
                                    : (animationDuration / 2).toInt()),
                            curve: widget.factor == 1
                                ? Curves.linear
                                : Curves.easeOutCirc,
                            width: double.infinity,
                            margin:
                                EdgeInsets.only(left: 59, bottom: 17, top: 36),
                            child: AnimatedTextKit(
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    'Communicate',
                                    textStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width <
                                                    337
                                                ? 27
                                                : 36,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white.withOpacity(1)),
                                    textAlign: TextAlign.start,
                                  )
                                ])),
                        AnimatedContainer(
                            duration: Duration(
                                milliseconds: widget.factor == 1
                                    ? animationDuration
                                    : (animationDuration / 2).toInt()),
                            curve: widget.factor == 1
                                ? Curves.linear
                                : Curves.easeOutCirc,
                            margin: EdgeInsets.only(left: 59),
                            width: double.infinity,
                            child: AnimatedTextKit(
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    'You can find the best suited team for you to join and make sure you will get the most befit from it',
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(1)),
                                    textAlign: TextAlign.start,
                                  )
                                ])),
                      ],
                    ),
                    // ),
                  ],
                )),
          ],
        ),
      ],
    );
  }
}

class onBorading_page3 extends StatefulWidget {
  double factor;

  onBorading_page3(this.factor);

  @override
  State<onBorading_page3> createState() => _onBorading_pageState3();
}

class _onBorading_pageState3 extends State<onBorading_page3> {
  double opacity = 0;
  int animationDuration = 700;
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(
            milliseconds: widget.factor == 1
                ? animationDuration
                : (animationDuration / 2).toInt()), () {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        // Displaying a stack
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Centering the image
            Container(
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: Duration(
                    milliseconds: widget.factor == 1
                        ? animationDuration
                        : (animationDuration / 2).toInt()),
                curve: widget.factor == 1 ? Curves.linear : Curves.easeOutCirc,
                alignment: Alignment.center,
                // Giving it a top margin in a responsive way
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (15 / 100)),
                // Giving it full width
                width: MediaQuery.of(context).size.width * widget.factor,
                child: Container(
                    // If the seed isn't 2 display the image only, if it is, display a stack that has the ellipse image and over it the image
                    child: SvgPicture.asset("assets/onBoarding/analytics.svg")),
              ),
            ),
            // To make the stack take full width and height
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            // Displaying a big circle border and changing its position according to the seed
            circle(
                3,
                widget.factor,
                0,
                "null",
                "0",
                190,
                Offset(-60, -69),
                Colors.transparent,
                Colors.transparent,
                AppColors.primaryColor,
                4,
                MediaQuery.of(context).size.width),
            // Displaying a small filled circle and changing its position according to the seed
            circle(
                3,
                widget.factor,
                65,
                "50",
                "null",
                30,
                Offset(0, 0),
                AppColors.primaryColor,
                Colors.transparent,
                Colors.transparent,
                0,
                MediaQuery.of(context).size.width),
            // Displaying a small circle border and changing its position according to the seed and giving it shadow and fill color if the seed is 1
            circle(
                3,
                widget.factor,
                MediaQuery.of(context).size.height * 0.93375,
                "null",
                "41",
                30,
                Offset(0, 0),
                Colors.transparent,
                Colors.transparent,
                AppColors.primaryColor,
                3,
                MediaQuery.of(context).size.width),
            // Displaying a different circle that has text in it
            AnimatedPositioned(
                duration: Duration(
                    milliseconds: widget.factor == 1
                        ? animationDuration
                        : (animationDuration / 2).toInt()),
                curve: widget.factor == 1 ? Curves.linear : Curves.easeOutCirc,
                // Positioning it in a way that makes it responsive
                top: MediaQuery.of(context).size.height * 0.61,
                left: -44,
                // Giving it full width and a height of 170
                width: MediaQuery.of(context).size.width * widget.factor,
                height: 170 * widget.factor,
                child:
                    // Displaying a stack that will have the circle and in top of it the text
                    Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(
                          milliseconds: widget.factor == 1
                              ? animationDuration
                              : (animationDuration / 2).toInt()),
                      curve: widget.factor == 1
                          ? Curves.linear
                          : Curves.easeOutCirc,
                      width: 190 * widget.factor,
                      height: 190 * widget.factor,
                      decoration: BoxDecoration(
                          // Giving it the standard red color if the seed isn't 2
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(250)),
                    ),
                    // Displaying a column and making it take the least size
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Displaying 2 animated containers with full width and giving it some margin and  making one for the title and the other for the text and making it black unless the seed is 2, it will be white
                        AnimatedContainer(
                            duration: Duration(
                                milliseconds: widget.factor == 1
                                    ? animationDuration
                                    : (animationDuration / 2).toInt()),
                            curve: widget.factor == 1
                                ? Curves.linear
                                : Curves.easeOutCirc,
                            width: double.infinity,
                            margin:
                                EdgeInsets.only(left: 59, bottom: 17, top: 36),
                            child: AnimatedTextKit(
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    'Reach',
                                    textStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width <
                                                    337
                                                ? 27
                                                : 36,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white.withOpacity(1)),
                                    textAlign: TextAlign.start,
                                  )
                                ])),
                        AnimatedContainer(
                            duration: Duration(
                                milliseconds: widget.factor == 1
                                    ? animationDuration
                                    : (animationDuration / 2).toInt()),
                            curve: widget.factor == 1
                                ? Curves.linear
                                : Curves.easeOutCirc,
                            margin: EdgeInsets.only(left: 59),
                            width: double.infinity,
                            child: AnimatedTextKit(
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    'Create profile for your team and deploy your team work to reach higher base of people that are interested in your work ',
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(1)),
                                    textAlign: TextAlign.start,
                                  )
                                ])),
                      ],
                    ),
                    // ),
                  ],
                )),
          ],
        ),
      ],
    );
  }
}

// A function that creates a circle instead of repeating the same lines for every circle
Widget circle(
    int seed,
    double factor,
    double top,
    String right,
    String left,
    double diameter,
    Offset offset,
    Color fill,
    Color shadowColor,
    Color borderColor,
    double borderWidth,
    double screenWidth,
    [int animationDuration = 1000]) {
  // left == "null"
  //     ? print(screenWidth - double.parse(right))
  //     : print(double.parse(left));
  // print("${screenWidth}, ${left} , ${right}");
  print(left == "null"
      ? "oh LORD 1 ${Offset(top, screenWidth - (double.parse(right)))}"
      : "oh LORD 2 ${Offset(top, double.parse(left))}");
  return AnimatedPositioned(
    duration: Duration(
        milliseconds:
            factor == 1 ? animationDuration : (animationDuration / 2).toInt()),
    curve: factor == 1 ? Curves.linear : Curves.easeOutCirc,
    // top: top,
    // left: left,
    // right: right,
    width: diameter * factor,
    height: diameter * factor,
    child: Transform.translate(
        offset: left == "null"
            ? Offset(screenWidth - (double.parse(right) + diameter), top)
            : Offset(double.parse(left), top),
        child: Transform.translate(
          offset: offset,
          child: Container(
            decoration: BoxDecoration(
                color: fill,
                border: Border.all(color: borderColor, width: 4),
                borderRadius: BorderRadius.circular(200),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                    blurRadius: borderWidth,
                  )
                ]),
          ),
        )),
  );
}

// Update the pages list
void updateList(pages, factor_1, factor_2, factor_3) {
  pages[0] = onBorading_page1(factor_1);
  pages[1] = onBorading_page2(factor_2);
  pages[2] = onBorading_page3(factor_3);
}

// class _onBoardingState extends State<onBoarding> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('OnBoarding'),
//           GestureDetector(
//             onTap: () {
//               Provider.of<MainRouterDelegate>(context, listen: false)
//                   .changeUser('0');
//             },
//             child: Container(
//               margin: const EdgeInsets.only(top: 8.0),
//               constraints: BoxConstraints.tight(const Size(80, 40)),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: AppColors.primaryColor, borderRadius: BorderRadius.circular(8.0)),
//               child: const Text('Next', style: TextStyle(color: Colors.white)),
//             ),
//           )
//         ],
//       ),
//     ));
//   }
// }

