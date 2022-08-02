import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectx/Data/Providers/MainProvider.dart';
import 'package:projectx/Utils/AppThemes.dart';
import 'package:projectx/Utils/Styles.dart';
import 'package:provider/provider.dart';

import '../../Data/Providers/MainRouterDelegate.dart';
import '../../Utils/AppColors.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Register'),
              GestureDetector(
                onTap: () {
                  Provider.of<MainRouterDelegate>(context, listen: false)
                      .changeUser('newId');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  constraints: BoxConstraints.tight(const Size(80, 40)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor, borderRadius: BorderRadius.circular(8.0)),
                  child: const Text('Register', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ));
  }

}

/*
class _RegisterState extends State<Register> {
  double? loginHeight;
  double? signupHeight;
  double loginOpacity = 1.0;
  double signupOpacity = 1.0;
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    var screenHeight = MediaQuery.of(context).size.height;
    loginHeight ??= screenHeight / 2;
    signupHeight ??= screenHeight / 2;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                height: loginHeight,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      24.0 , statusBarHeight + 24.0 , 48.0 ,  46.0),
                  constraints: const BoxConstraints.expand(),
                  alignment: Alignment.topLeft,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(28.0)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primaryColor,
                          AppColors.primaryColor,
                        ]),
                  ),
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    opacity: loginOpacity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome\nBack!',
                          style: Styles.title1,
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.white , width: 1)
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  textSelectionTheme: const TextSelectionThemeData(
                                    selectionHandleColor: Colors.white
                                  )
                                ),
                                child: TextFormField(
                                   decoration: InputDecoration(
                                      labelText: 'Email Address',
                                      border: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.transparent)),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.transparent)),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.transparent)),
                                      labelStyle: TextStyle(
                                          color: Colors.white.withOpacity(.8)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14.0 , vertical: 8.0),
                                  ),
                                  style: Styles.textField1,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  autofillHints: [AutofillHints.email],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.white , width: 1)
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: const UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.transparent)),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.transparent)),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.transparent)),
                                    labelStyle: TextStyle(
                                        color: Colors.white.withOpacity(.8)),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14.0 , vertical: 8.0),
                                    suffixIcon: const Padding(
                                      padding: EdgeInsets.only(right: 12.0),
                                      child: Icon(CupertinoIcons.eye_solid , color: Colors.white,),
                                    ),

                              ),
                                cursorColor: Colors.white.withOpacity(.5),
                                style: Styles.textField1,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                autofillHints: const [AutofillHints.password],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text('Forgot Password?' , style: Styles.text1.copyWith(fontSize: 12 ,color: Colors.white.withOpacity(.75)),),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 26.0 , vertical: 12.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(.25),
                                    offset: Offset(2.0 , 2.0),
                                    blurRadius: 4,
                                    spreadRadius: 0
                                  )
                                ]
                              ),
                              child: Text(
                                'Login',
                                style: Styles.text1.copyWith(color: AppColors.primaryColorDark , fontSize: 18.0),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                height: signupHeight,
                child: Stack(
                  children: [
                    Container(
                      color: AppColors.primaryColor,
                    ),
                    Theme(
                      data:  AppThemes.textTheme2,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            24.0 , 24.0 , 48.0 ,  8.0),
                        constraints: const BoxConstraints.expand(),
                        alignment: Alignment.topLeft,
                        decoration: const BoxDecoration(
                            borderRadius:
                            BorderRadius.only(topRight: Radius.circular(28.0)),
                            color: Colors.white),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          opacity: signupOpacity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create\naccount!',
                                style: Styles.title1.copyWith(color: AppColors.primaryColor),
                              ),

                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/facebook.svg', height: 36.0, width: 36.0,),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 14.0),
                                    height: 36.0,
                                      width: 36.0,
                                      padding: EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF50ABF1)
                                      ),
                                      child: SvgPicture.asset('assets/twitter.svg', color: Colors.white,)),
                                  SvgPicture.asset('assets/google.svg', height: 36.0, width: 36.0,),
                                ],
                              ),
                              Spacer(),

                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: AppColors.primaryColor , width: 1)
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        border: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.transparent)),
                                        enabledBorder: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.transparent)),
                                        focusedBorder: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.transparent)),
                                        labelStyle: TextStyle(
                                            color: AppColors.primaryColor.withOpacity(.8)),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 14.0 , vertical: 8.0),
                                      ),
                                      style: Styles.textField1.copyWith(color: AppColors.primaryColor),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.name,
                                      autofillHints: [AutofillHints.name],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: AppColors.primaryColor , width: 1)
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Email Address',
                                        border: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.transparent)),
                                        enabledBorder: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.transparent)),
                                        focusedBorder: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.transparent)),
                                        labelStyle: TextStyle(
                                            color: AppColors.primaryColor.withOpacity(.8)),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 14.0 , vertical: 8.0),
                                      ),
                                      style: Styles.textField1.copyWith(color: AppColors.primaryColor),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.emailAddress,
                                      autofillHints: [AutofillHints.email],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: AppColors.primaryColor , width: 1)
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        border: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.transparent)),
                                        enabledBorder: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.transparent)),
                                        focusedBorder: const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.transparent)),
                                        labelStyle: TextStyle(
                                            color: AppColors.primaryColor.withOpacity(.8)),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 14.0 , vertical: 8.0),
                                                    ),
                                      style: Styles.textField1.copyWith(color: AppColors.primaryColor),
                                      keyboardType: TextInputType.text,
                                      autofillHints: const [AutofillHints.password],
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children:[
                                  Spacer(),
                                  Container(
                                  padding: EdgeInsets.symmetric(horizontal: 26.0 , vertical: 12.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(12.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.primaryColor.withOpacity(.25),
                                            offset: Offset(2.0 , 2.0),
                                            blurRadius: 4,
                                            spreadRadius: 0
                                        )
                                      ]
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: Styles.text1.copyWith(color: Colors.white , fontSize: 18.0),
                                  ),
                                ),
    ]
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AnimatedPositioned(
            left: 0,
            right: 0,
            top: loginHeight! - 38,
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    setState((){
                      signupHeight = screenHeight- 100;
                      loginHeight = screenHeight - signupHeight!;
                      loginOpacity = 0.0;
                      signupOpacity = 1.0;
                    });
                  },
                  child: Transform.translate(
                    offset: Offset(1.0 , 0.0),
                    child: Container(
                      width: 76,
                      height: 76,
                      margin: EdgeInsets.only(bottom: 14.0),
                      padding: EdgeInsets.only(bottom: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),
                      child: Icon(Icons.keyboard_arrow_up_rounded , color: AppColors.primaryColor, size: 60,),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState((){
                      loginHeight = screenHeight - 100;
                      signupHeight = screenHeight - loginHeight!;
                      loginOpacity = 1.0;
                      signupOpacity = 0.0;
                    });
                  },
                  child: Transform.translate(
                    offset: Offset(-1.0 , 0.0),
                    child: Container(
                      width: 76,
                      height: 76,
                      margin: EdgeInsets.only(top: 14.0),
                      padding: EdgeInsets.only(top: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor
                      ),
                      child: Icon(Icons.keyboard_arrow_down_rounded , color: Colors.white, size: 60,),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
*/