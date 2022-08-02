import 'package:flutter/material.dart';
import 'package:projectx/Data/Providers/MainProvider.dart';
import 'package:projectx/Utils/AppColors.dart';
import 'package:provider/provider.dart';

import '../../Data/Providers/MainRouterDelegate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Home'),
          GestureDetector(
            onTap: () {
              Provider.of<MainProvider>(context, listen: false)
                  .sharedPreferences
                  .setString('userId', '0');
              Provider.of<MainRouterDelegate>(context, listen: false)
                  .changeUser('0');
            },
            child: Container(
              margin: const EdgeInsets.only(top: 8.0),
              constraints: BoxConstraints.tight(const Size(80, 40)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor, borderRadius: BorderRadius.circular(8.0)),
              child:
                  const Text('Sign Out', style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    ));
  }
}
