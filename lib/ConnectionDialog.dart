import 'package:flutter/material.dart';
import 'package:http/http.dart';


class ConnectionDialog extends StatefulWidget{
  const ConnectionDialog({super.key});

  @override
  _ConnectionDialog createState() {
    return _ConnectionDialog();
  }

}

class _ConnectionDialog extends State<ConnectionDialog>{
  final TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }




  void _tryToConnnect(BuildContext context) async {
    String ipAdress = _controller.text;
    RegExp reg = RegExp(r"(\d+\.){3}\d{1,2}$");
    if(!reg.hasMatch(ipAdress)){
      showTheAlertMessage(
          title: "Invalide",
          message: "Entrer une adresse ip valide!",
          buildContext: context
      );
    } else {
      try {
        final resp = await get(Uri(
            scheme:"http",
            host: ipAdress,
            port: 6789,
            path: "connection-test"
        ));
        Navigator.pop(context,ipAdress);
      } catch(e){
        print(e);
        showTheAlertMessage(
            title: "Erreur",
            message: "La connexion sur ${ipAdress} a echoue",
                buildContext: context
            );
          }
      }
  }

  void showTheAlertMessage({ title, message, buildContext }){
    showDialog(
        context: buildContext,
        builder: (BuildContext context2){
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              ElevatedButton(
                  onPressed: () => {
                    Navigator.pop(buildContext)
                  },
                  child: Text("Ok") )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Connection"),
      content: Focus(
        focusNode: _focusNode,
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(
              labelText: "Adresse Ip",
              labelStyle: TextStyle(
                fontSize: 16,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1)
              )
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () => { Navigator.pop(context)},
            child: Text("Annuler")
        ),
        ElevatedButton(
            onPressed: () => _tryToConnnect(context),
            child: Text("Connecter")
        )
      ],
    );
  }

}

