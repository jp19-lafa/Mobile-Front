import 'package:farm_lab_mobile/components/tab_item.dart';
import 'package:farm_lab_mobile/models/authentication.dart';
import 'package:farm_lab_mobile/screens/node_summary_page.dart';
import 'package:farm_lab_mobile/services/authentication_helper.dart';
import 'package:farm_lab_mobile/services/globals.dart' as global;
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  TextEditingController firstnameTextEditingController = TextEditingController();
  TextEditingController lastnameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TabController tabController;
  AuthenticationHelper authenticationHelper =
      AuthenticationHelper(global.networkHelper);
  bool loginTabActive = true;

  bool isValidEmailAdress(String address) {
    if (RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(address)) {
      return true;
    } else {
      return false;
    }
  }

  void login() {
    if (emailTextEditingController.text != null &&
        passwordTextEditingController != null) {
      if (isValidEmailAdress(emailTextEditingController.text)) {
        Login login = Login(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text);
        authenticationHelper.login(login).then(
          (data) {
            if (data is Token) {
              Token token = data;
              global.token = token.jwt;
              global.refreshToken = token.refresh;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NodeSummaryPage(),
                ),
              );
            }
          },
        );
      } else {
        print('Invalid email adress');
      }
    } else {
      print('One or more fields not filled in');
    }
  }

  void register() {}

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/logo.png',
                            width: 200,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            'FarmLab',
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 120),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            TabItem(
                              text: 'Login',
                              active: loginTabActive,
                              onPressed: () {
                                setState(() {
                                  loginTabActive = true;
                                  tabController.animateTo(0);
                                });
                              },
                            ),
                            TabItem(
                              text: 'Register',
                              active: !loginTabActive,
                              onPressed: () {
                                setState(() {
                                  loginTabActive = false;
                                  tabController.animateTo(1);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: <Widget>[
                      ListView(
                        children: <Widget>[
                          TextField(
                            controller: emailTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: passwordTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RaisedButton(
                            child: Text('Login'),
                            onPressed: () {
                              login();
                            },
                          ),
                        ],
                      ),
                      ListView(
                        children: <Widget>[
                          TextField(
                            controller: firstnameTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Firstname',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: lastnameTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Lastname',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: emailTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: passwordTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: confirmPasswordTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Confirm password',
                            ),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RaisedButton(
                            child: Text('Register'),
                            onPressed: () {
                              register();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
