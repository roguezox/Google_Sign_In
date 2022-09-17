import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          color: Colors.white60,
          image: DecorationImage(
              image: AssetImage("assets/doodle.jpg"),
              opacity: 0.1,
              fit: BoxFit.cover)),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, -0.8),
            child: Text("NEOM",
                style: GoogleFonts.montserrat(
                    fontSize: 43,
                    fontWeight: FontWeight.w200,
                    shadows: <Shadow>[
                      const Shadow(
                          offset: Offset(0.0, 2.0),
                          blurRadius: 5.0,
                          color: Colors.black87),
                    ])),
          ),
          Align(
            alignment: const Alignment(-0.7, 0.47),
            child: Text("Welcome, ",
                style: GoogleFonts.montserrat(
                    fontSize: 23,
                    fontWeight: FontWeight.w300,
                    shadows: <Shadow>[
                      const Shadow(
                          offset: Offset(0.0, 1),
                          blurRadius: 1,
                          color: Colors.black87),
                    ])),
          ),
          Align(
            alignment: const Alignment(-0.68, 0.57),
            child: Text("Google Sign In, ",
                style: GoogleFonts.montserrat(
                    fontSize: 21,
                    fontWeight: FontWeight.w200,
                    shadows: <Shadow>[
                      const Shadow(
                          offset: Offset(0.0, 1),
                          blurRadius: 1,
                          color: Colors.black87),
                    ])),
          ),
          Align(
              alignment: const Alignment(0, 0.78),
              child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 0.06,
                child: PhysicalModel(
                    color: Colors.black87,
                    elevation: 8,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent,

                        //make color or elevated button transparent
                      ),
                      onPressed: () {
                        signInWithGoogle(context: context);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )),
              )),
          Align(
              alignment: const Alignment(0, -0.18),
              child: Flexible(
                child: Image.asset(
                  'assets/go.png',
                  width: 170,
                  height: 170,
                ),
              ))
        ],
      ),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        print(user?.displayName);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => homepage(user: user)),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }
}
