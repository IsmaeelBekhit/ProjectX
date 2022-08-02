import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Data/Providers/MainRouterDelegate.dart';
import '../../Utils/AppColors.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({Key? key}) : super(key: key);

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('OnBoarding'),
          GestureDetector(
            onTap: () {
              Provider.of<MainRouterDelegate>(context, listen: false)
                  .changeUser('0');
            },
            child: Container(
              margin: const EdgeInsets.only(top: 8.0),
              constraints: BoxConstraints.tight(const Size(80, 40)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor, borderRadius: BorderRadius.circular(8.0)),
              child: const Text('Next', style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    ));
  }
}
