import 'package:application_mobile_development/auth_profile.dart';
import 'package:application_mobile_development/data/network/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplication Mobile Develovment',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Aplication Mobile Develovment'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  AuthProfile authProfile = AuthProfile();

  @override
  Widget build(BuildContext context) {

    void signInWithGoogle() async {
      await FirebaseService().signInWithGoogle().then((value) => {
        authProfile = AuthProfile(
            uid: value?.user?.uid ?? '',
            name: value?.user?.displayName ?? ''
        )
      });

      setState(() {

      });
    }

    void signOut() async {
      await FirebaseService().signOut().then((value) => {
        authProfile = AuthProfile()
      });

      setState(() {

      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: authProfile.uid.isEmpty ? Card(
            color: Colors.white,
            elevation: 2,
            margin: const EdgeInsets.all(40),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                signInWithGoogle();
              },
              child: Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                    child: SizedBox(
                        width: 225,
                        child: Row(
                          children: [
                            const Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Sign in With Google',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 21,
                              width: 21,
                              child: SvgPicture.asset('assets/icons/ic_google.svg'),
                            )
                          ],
                        )
                    )
                ),
              ),
            ),
          ) : Card(
            color: Colors.white,
            elevation: 2,
            margin: const EdgeInsets.all(16),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                signOut();
              },
              child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: 140,
                  child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Selamat Datang ${authProfile.name}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Card(
                              color: Colors.black,
                              elevation: 2,
                              margin: const EdgeInsets.only(top: 40),
                              clipBehavior: Clip.hardEdge,
                              child: InkWell(
                                  splashColor: Colors.blue.withAlpha(30),
                                  onTap: () {
                                    signOut();
                                  },
                                  child: const SizedBox(
                                      height: 40,
                                      width: 100,
                                      child: Center(
                                        child: Text(
                                          'Logout',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                  )
                              )
                          ),
                        ],
                      )
                  )
              ),
            ),
          ),
        )
    );
  }
}
