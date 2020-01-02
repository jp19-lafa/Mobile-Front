import 'package:farm_lab_mobile/components/tab_item.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TabController tabController;
  bool loginTabActive = true;

  void login() {}

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'FarmLab',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Image.asset(
                      'assets/logo.png',
                    ),
                  ),
                  Row(
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
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10),
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
                    controller: tabController,
                    children: <Widget>[
                      ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          TextField(
                            controller: emailTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: passwordTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          TextField(
                            controller: emailTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: passwordTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: confirmPasswordTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Confirm password',
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
