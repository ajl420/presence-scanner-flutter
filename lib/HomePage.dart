import "package:flutter/material.dart";
import "ConnectionDialog.dart";


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  void beginRemote(BuildContext context) async{
      final value = await showDialog(
          context: context,
          builder: (BuildContext context2){
            return const ConnectionDialog();
          }
      );

      if(value != null){
        Navigator.pushNamed(context,"/scanner", arguments: value);
      }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
         child: Stack(
           children: [
             Center(
               child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 50
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 164,
                          height: 164,
                          child: Image.asset(
                            "assets/Icons/wifi.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Text(
                            "Commencer la presence par scan",
                            style: TextStyle(
                              fontSize: 18
                            ),
                        )
                      ],
                    ),
               ),
             ),
             Align(
               alignment: Alignment.bottomCenter,
               child: Container(
                 width: double.infinity, // Prend la largeur totale de l'écran
                 padding: EdgeInsets.all(16.0), // Ajoute du padding au bouton si nécessaire
                 child: ElevatedButton(
                   onPressed: () => beginRemote(context),
                   child: Text("Commencer"),
                 ),
               ),
             ),
           ],
         ),
      )
    );
  }
}
