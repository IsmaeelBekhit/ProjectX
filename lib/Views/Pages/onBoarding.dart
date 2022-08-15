import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    onBorading_page(
        "Join",
        "You can find the best suited team for you to join and make sure you will get the most befit from it",
        "assets/onBoarding/nerd.svg",
        1,
        19.59,
        0),
    onBorading_page(
        "Communicate",
        "You can find the best suited team for you to join and make sure you will get the most befit from it",
        "assets/onBoarding/chat.svg",
        2,
        9.125,
        0),
    onBorading_page(
        "Reach",
        "Create profile for your team and deploy your team work to reach higher base of people that are interested in your work ",
        "assets/onBoarding/analytics.svg",
        3,
        15,
        0)
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
    int animation_duration = 1000;
    return Scaffold(
      body: Container(
        // Displaying a stack
        child: Stack(
          children: <Widget>[
            SvgPicture.asset("assets/analytics.svg"),
            // Displaying an object at the bottom right of the page in the background
            AnimatedPositioned(
                duration: Duration(milliseconds: animation_duration),
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
                        ? 136
                        : 329,
                height: currentPage == 1
                    ? MediaQuery.of(context).size.width >
                            MediaQuery.of(context).size.height
                        ? MediaQuery.of(context).size.width * 1.6
                        : MediaQuery.of(context).size.height * 1.6
                    : 136,
                child: Transform.translate(
                  // if it's not the last page move it by an offset(68, 68) else move it by an offset(215, 83)
                  offset: currentPage != pages.length - 1
                      ? Offset(68, 68)
                      : Offset(215, 83),
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
                                  : BorderRadius.circular(16))),
                )),
            // Displaying the pages
            Positioned(
              child: Container(
                color: Colors.transparent,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  itemCount: pages.length,
                  physics: NeverScrollableScrollPhysics(),
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
                      InkWell(
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
                            : null,
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
                                      : AppColors.primaryColor.withOpacity(0.5)
                                  : (index == currentPage)
                                      ? Color(0xffffffff)
                                      : Color(0xffffffff).withOpacity(0.5),
                              boxShadow: [
                                BoxShadow(
                                  color: (index == currentPage)
                                      ? AppColors.primaryColor.withOpacity(0.25)
                                      : Colors.transparent,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                )
                              ],
                            ),
                          );
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
              duration: Duration(
                  milliseconds: int.parse((animation_duration / 2).toString())),
              bottom: 0,
              right: 0,
              // if it's not the last page make its width 136 else make it 329
              width: currentPage != pages.length - 1 ? 136 : 329,
              height: 136,
              // if it's not the last page move by an offset of (68, 68) and if it's clicked go to the next page, else move it by (215, 83) and call the popout function
              child: Transform.translate(
                offset: currentPage != pages.length - 1
                    ? Offset(68, 68)
                    : Offset(215, 83),
                child: InkWell(
                  onTap: () {
                    if (currentPage != pages.length - 1) {
                      popout();
                      setState(() {
                        currentPage++;
                      });
                      Timer(Duration(milliseconds: animation_duration), () {
                        pageController.nextPage(
                            duration: Duration(
                                milliseconds: int.parse(
                                    (animation_duration / 10).toString())),
                            curve: Curves.linear);
                      });
                    } else {
                      popout();
                    }
                    // });
                  },
                  // Making the button a circle and aligning it's children at the top left and giving it some padding
                  child: AnimatedContainer(
                    duration: Duration(
                        milliseconds:
                            int.parse((animation_duration / 2).toString())),
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        // If it's not the second page make its color red else make it white
                        color: currentPage != 1
                            ? AppColors.primaryColor
                            : Colors.white,
                        borderRadius: currentPage != pages.length - 1
                            ? BorderRadius.circular(200)
                            : BorderRadius.circular(16)),
                    child: Positioned(
                      // if it's not the last page make it's child an icon and make it red if it's the second page if it isn't make it white
                      // Else, it's last page make it's child a text "start now"
                      child: currentPage != pages.length - 1
                          ? Icon(Icons.navigate_next_rounded,
                              color: currentPage != 1
                                  ? Colors.white
                                  : AppColors.primaryColor,
                              size: 35)
                          : Text("Start Now!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700)),
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
                      color: currentPage == 1 ? Colors.white : null),
                )),
          ],
        ),
      ),
    );
  }
}

class onBorading_page extends StatefulWidget {
  final String title;
  final String text;
  final String image;
  final int seed;
  final double top_margin_percent;
  double factor;

  onBorading_page(this.title, this.text, this.image, this.seed,
      this.top_margin_percent, this.factor);

  @override
  State<onBorading_page> createState() => _onBorading_pageState();
}

class _onBorading_pageState extends State<onBorading_page> {
  double opacity = 0;
  int animation_duration = 1000;
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(
            milliseconds: widget.factor == 1
                ? animation_duration
                : int.parse((animation_duration / 2).toString())), () {
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
                        ? animation_duration
                        : int.parse((animation_duration / 2).toString())),
                curve: widget.factor == 1 ? Curves.linear : Curves.easeOutCirc,
                alignment: Alignment.center,
                // Giving it a top margin in a responsive way
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height *
                        (widget.top_margin_percent / 100)),
                // Giving it full width
                width: MediaQuery.of(context).size.width * widget.factor,
                child: Container(
                    // If the seed isn't 2 display the image only, if it is, display a stack that has the ellipse image and over it the image
                    child: widget.seed != 2
                        ? SvgPicture.asset(widget.image)
                        : Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                                SvgPicture.asset(
                                  "assets/onBoarding/bg_ellipse.svg",
                                  allowDrawingOutsideViewBox: true,

                                  // width: MediaQuery.of(context).size.width,
                                  // height: 423.31,
                                ),
                                SvgPicture.asset(widget.image),
                              ])),
              ),
            ),
            // To make the stack take full width and height
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            // Displaying a big circle border and changing its position according to the seed
            circle(
                widget.seed,
                widget.factor,
                0,
                widget.seed == 1 ? 0 : null,
                widget.seed == 3 ? 0 : null,
                190,
                widget.seed == 1 ? Offset(27, -87) : Offset(-60, -69),
                Colors.transparent,
                Colors.transparent,
                widget.seed != 2 ? AppColors.primaryColor : Colors.transparent,
                4),
            // Displaying a small filled circle and changing its position according to the seed
            circle(
                widget.seed,
                widget.factor,
                widget.seed == 1 ? 103 : 65,
                widget.seed == 3 ? 50 : null,
                widget.seed == 1 ? 53 : null,
                30,
                Offset(0, 0),
                widget.seed != 2 ? AppColors.primaryColor : null,
                Colors.transparent,
                Colors.transparent,
                0),
            // Displaying a small circle border and changing its position according to the seed and giving it shadow and fill color if the seed is 1
            circle(
                widget.seed,
                widget.factor,
                widget.seed == 1
                    ? MediaQuery.of(context).size.height * 0.6325
                    : MediaQuery.of(context).size.height * 0.93375,
                widget.seed == 1 ? 32 : null,
                widget.seed == 3 ? 41 : null,
                30,
                Offset(0, 0),
                widget.seed == 1 ? Colors.white : null,
                widget.seed == 1
                    ? AppColors.primaryColor.withOpacity(0.25)
                    : Colors.transparent,
                widget.seed != 2 ? AppColors.primaryColor : Colors.transparent,
                3),
            // Displaying a different circle that has text in it
            AnimatedPositioned(
                duration: Duration(
                    milliseconds: widget.factor == 1
                        ? animation_duration
                        : int.parse((animation_duration / 2).toString())),
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
                              ? animation_duration
                              : int.parse((animation_duration / 2).toString())),
                      curve: widget.factor == 1
                          ? Curves.linear
                          : Curves.easeOutCirc,
                      width: 190 * widget.factor,
                      height: 170 * widget.factor,
                      decoration: BoxDecoration(
                          // Giving it the standard red color if the seed isn't 2
                          color:
                              widget.seed != 2 ? AppColors.primaryColor : null,
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
                                  ? animation_duration
                                  : int.parse(
                                      (animation_duration / 2).toString())),
                          curve: widget.factor == 1
                              ? Curves.linear
                              : Curves.easeOutCirc,
                          width: double.infinity,
                          margin:
                              EdgeInsets.only(left: 59, bottom: 17, top: 36),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: Colors.white.withOpacity(
                                    widget.factor == 0
                                        ? widget.factor
                                        : opacity)),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(
                              milliseconds: widget.factor == 1
                                  ? animation_duration
                                  : int.parse(
                                      (animation_duration / 2).toString())),
                          curve: widget.factor == 1
                              ? Curves.linear
                              : Curves.easeOutCirc,
                          margin: EdgeInsets.only(left: 59),
                          width: double.infinity,
                          child: Text(
                            widget.text,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: widget.seed != 2
                                    ? Colors.black.withOpacity(
                                        widget.factor == 0
                                            ? widget.factor
                                            : opacity)
                                    : Colors.white.withOpacity(
                                        widget.factor == 0
                                            ? widget.factor
                                            : opacity)),
                            textAlign: TextAlign.start,
                          ),
                        ),
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
Widget circle(int seed, double factor, top, right, left, diameter, offset, fill,
    shadow_color, border_color, border_width,
    [animation_duration = 1000]) {
  return AnimatedPositioned(
    duration: Duration(
        milliseconds: factor == 1
            ? animation_duration
            : int.parse((animation_duration / 2).toString())),
    curve: factor == 1 ? Curves.linear : Curves.easeOutCirc,
    top: top,
    left: left,
    right: right,
    width: diameter * factor,
    height: diameter * factor,
    child: Transform.translate(
      offset: offset,
      child: Container(
        decoration: BoxDecoration(
            color: fill,
            border: Border.all(color: border_color, width: 4),
            borderRadius: BorderRadius.circular(200),
            boxShadow: [
              BoxShadow(
                color: shadow_color,
                offset: Offset(0, 4),
                spreadRadius: 0,
                blurRadius: border_width,
              )
            ]),
      ),
    ),
  );
}

// Update the pages list
void updateList(pages, factor_1, factor_2, factor_3) {
  pages[0] = onBorading_page(
      "Join",
      "You can find the best suited team for you to join and make sure you will get the most befit from it",
      "assets/onBoarding/nerd.svg",
      1,
      19.59,
      factor_1);
  pages[1] = onBorading_page(
      "Communicate",
      "You can find the best suited team for you to join and make sure you will get the most befit from it",
      "assets/onBoarding/chat.svg",
      2,
      9.125,
      factor_2);
  pages[2] = onBorading_page(
      "Reach",
      "Create profile for your team and deploy your team work to reach higher base of people that are interested in your work ",
      "assets/onBoarding/analytics.svg",
      3,
      15,
      factor_3);
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

