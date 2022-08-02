import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectx/Data/Providers/MainRouterDelegate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Data/Providers/MainProvider.dart';
import '../../Utils/AppColors.dart';

late MainProvider mainProvider;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'Logo',
          //TODO: add the logo animation
          child: Container(
            width: 100,
            height: 100,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }


  void init() {
    Future.delayed(const Duration(seconds: 5) , ()async{
      mainProvider = Provider.of<MainProvider>(context , listen: false);
      mainProvider.sharedPreferences = await SharedPreferences.getInstance();
      String? userID = mainProvider.sharedPreferences.getString('userId');
      if (!mounted) return;
      if(userID == null) {
        Provider.of<MainRouterDelegate>(context , listen: false).changeUser('newUser');
      } else if (userID.isEmpty) {
        Provider.of<MainRouterDelegate>(context, listen: false).changeUser('0');
      }else {
        Provider.of<MainRouterDelegate>(context, listen: false).changeUser(userID);
      }
    });


  }

  @override
  void initState() {
    init();
    super.initState();
  }
}
