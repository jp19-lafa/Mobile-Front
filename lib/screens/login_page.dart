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
  TextEditingController firstnameTextEditingController =
      TextEditingController();
  TextEditingController lastnameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TabController tabController;
  AuthenticationHelper authenticationHelper =
      AuthenticationHelper(global.networkHelper);
  bool loginTabActive = true;

  void checkForToken() async {
    Token token = Token();
    await token.load();
    if (token.jwt != '') {
      login(token);
    }
  }

  bool isValidEmailAdress(String address) {
    if (RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(address)) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidPassword(String password) {
    if (RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}").hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  void loginAction() async {
    if (emailTextEditingController.text != null &&
        passwordTextEditingController != null) {
      if (isValidEmailAdress(emailTextEditingController.text)) {
        UserDetails loginDetails = UserDetails(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text);
        dynamic data = await authenticationHelper.login(loginDetails);
        login(data);
      } else {
        print('Invalid email adress');
      }
    } else {
      print('One or more fields not filled in');
    }
  }

  void registerAction() async {
    if (firstnameTextEditingController.text != null &&
        lastnameTextEditingController != null &&
        emailTextEditingController.text != null &&
        passwordTextEditingController != null) {
      if (isValidEmailAdress(emailTextEditingController.text)) {
        if (isValidPassword(passwordTextEditingController.text)) {
          UserDetails registerDetails = UserDetails(
              firstname: firstnameTextEditingController.text,
              lastname: lastnameTextEditingController.text,
              email: emailTextEditingController.text,
              password: passwordTextEditingController.text);
          dynamic data = await authenticationHelper.register(registerDetails);
          login(data);
        } else {
          print('Invallid password');
        }
      } else {
        print('Invalid email adress');
      }
    } else {
      print('One or more fields not filled in');
    }
  }

  void login(var data) async{
    if (data is Token) {
      Token token = data;
      await token.store();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NodeSummaryPage(),
        ),
      );
    } else {
      print(data);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkForToken());
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
                              loginAction();
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
                              registerAction();
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
