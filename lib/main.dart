import 'package:swipet_mobile/components/router.dart';
import 'package:swipet_mobile/dbHelper/mongodb.dart';
import 'package:swipet_mobile/pages/login_page.dart';
import 'package:swipet_mobile/pages/signup_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/welcome': (BuildContext context) =>
            const WelcomePage(),
        '/signup': (BuildContext context) =>
            const SignupPage(),
        '/login': (BuildContext context) =>
            const LoginPage(),
      },
      theme: ThemeData(
          fontFamily: 'DM Sans',
          primaryColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
    );
  }
}

// Welcome Page
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() =>
      _WelcomePageState();
}

class _WelcomePageState
    extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(
            242, 136, 164, 1),
        body: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                //          App Name with Logo
                children: [
                  const Text(
                    "SwiPet",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontFamily: 'Recoleta'),
                  ),
                  Padding(
                    //            Logo
                    padding:
                        const EdgeInsets.only(
                            left: 15, bottom: 10),
                    child: Image.asset(
                        'lib/images/logo.png'),
                  )
                ],
              ),
              //                Description
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Discover your Pet \n Soulmate!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              //                Divider
              const Divider(
                indent: 100,
                endIndent: 100,
                height: 25,
                color: Colors.white,
              ),
              //                Get Started Button
              Padding(
                padding: const EdgeInsets.only(
                    top: 20),
                child: ElevatedButton(
                    onPressed: () {
                      ScreenNavigator(cx: context)
                          .navigate(
                              const SignupPage(),
                              NavigatorTweens
                                  .bottomToTop());
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(
                              horizontal: 35,
                              vertical: 15),
                      child: Text(
                        "Let's Go!",
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 25,
                            color: Color.fromRGBO(
                                251,
                                121,
                                156,
                                1)),
                      ),
                    )),
              ),
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                'lib/images/landingCat.png',
              )
            ],
          ),
        ));
  }
}
