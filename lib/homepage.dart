import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



class homepage extends StatefulWidget {
  const homepage({Key? key, required User? user}): _user = user, super(key: key);

  final User? _user;

  @override
  _homepage createState() => _homepage();
}

class _homepage extends State<homepage> {
  late User _user;


  @override
  void initState() {
    _user = widget._user!;

    super.initState();
  }
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/doodle.jpg"),opacity: 0.15,fit: BoxFit.cover),
        ),
        child: Stack(
          children: <Widget>[

            Align(

              child: FractionallySizedBox(


                  child: Stack(

                    children: <Widget>[

                      Align(
                        alignment: const Alignment(0,-0.2),
                        child: ClipOval(
                          child: Material(
                            color: Colors.black87,
                            child: Image.network(
                              _user.photoURL!,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        )
                      ),

                      Align(
                        alignment: const Alignment(0,0.1),
                        child: AutoSizeText(
                          "Name: ${_user.displayName}",
                            maxLines: 1,
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                shadows: <Shadow>[
                                  const Shadow(
                                      offset: Offset(0.0, 1),
                                      blurRadius: 1,
                                      color: Colors.black87
                                  ),
                                ]

                            )
                        ),
                      ),


                      Align(
                        alignment: const Alignment(0,0.2),
                        child: AutoSizeText(
                          "Email: ${_user.email}",
                           maxLines: 1,
                           style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            shadows: <Shadow>[
                              const Shadow(
                                  offset: Offset(0.0, 1),
                                  blurRadius: 1,
                                  color: Colors.black87
                              ),
                            ]

                        )
                        ),
                      ),

                      Align(
                        alignment: const Alignment(0,0.75),

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

                                    signOut();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const MyApp()),
                                    );


                                  },

                                  child: const Text('Sign Out', style: TextStyle( color: Colors.white),),

                                )

                            ),

                          )
                      )


                    ],
                  ),

              ),
            )


          ],
        ),
      ),
    );
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    if (kDebugMode) {
      print("User Sign Out");
    }
  }

}


