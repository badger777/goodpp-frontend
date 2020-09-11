import 'dart:developer' as developer;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/empty_app_bar_widget.dart';
import 'package:gpp_app/widgets/app_icon_widget.dart';
import 'package:gpp_app/constants/text_style.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(), //empty_app_bar_widget
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Material(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(flex: 5, child: _buildUpSide()),
        Expanded(flex: 3, child: _buildCenterSide()),
        Expanded(flex: 1, child: _buildDownSide()),
      ],
    ));
  }

  Widget _buildUpSide() {
    return Material(
        child: Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text('굿푸피', style: h1Style))),
        Expanded(
          flex: 2,
          child: Center(child: AppIconWidget(image: Assets.appLogo)),
        ),
        Expanded(
            flex: 1,
            child: Align(
                alignment: Alignment.topCenter,
                child: Text('반려견 지능형 배변훈련 서비스',
                    style: new TextStyle(
                      fontSize: h2Style.fontSize,
                      color: Colors.black,
                    )))),
      ],
    ));
  }

  Widget _buildCenterSide() {
    return Material(
        child: Column(
      children: <Widget>[
        SizedBox(height: getBlockSizeVertical(0.8)),
        Container(
          width: getBlockSizeHorizontal(70),
          height: getBlockSizeVertical(7),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email",
              hintText: "Enter your email",
            ),
          ),
        ),
        SizedBox(height: getBlockSizeVertical(0.8)),
        Container(
          width: getBlockSizeHorizontal(70),
          height: getBlockSizeVertical(7),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              hintText: "Enter your password",
            ),
          ),
        ),
        SizedBox(height: getBlockSizeVertical(0.8)),
        SizedBox(
          width: getBlockSizeHorizontal(70),
          height: getBlockSizeVertical(7),
          child: RaisedButton(
            child: Text('로그인'),
            onPressed: loginTapped,
            textColor: Colors.white,
            color: kPrimaryLightColor,
          ),
        ),
      ],
    ));
  }

  Widget _buildDownSide() {
    return Material(
        child: Center(
            child: RichText(
                text: new TextSpan(children: [
      new TextSpan(
          text: '아직 굿푸피 계정이 없으신가요? ',
          style: new TextStyle(fontSize: pStyle.fontSize, color: Colors.black)),
      new TextSpan(
          text: '회원가입',
          style: new TextStyle(
              fontSize: h2Style.fontSize,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold),
          recognizer: new TapGestureRecognizer()..onTap = registerTapped)
    ]))));
  }

  void loginTapped() {
    developer.log('login.dart: login button tapped',
        name: 'MY.DEBUG', level: 10);
    Navigator.of(context).pushNamed(Routes.report);
  }

  void registerTapped() {
    developer.log('login.dart: register link tapped',
        name: 'MY.DEBUG', level: 10);
    Navigator.of(context).pushNamed(Routes.register);
  }
}
