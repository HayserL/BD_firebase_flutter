import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba_bd/behaviors/hiddenScrollBehavior.dart';
 class ForgotPasswordPage extends StatefulWidget {
   ForgotPasswordPage({Key key}) : super(key: key);
 
   _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
 }
 
 class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _fomrkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  String _email;

  bool _isenviandopass = false;

  _forgotPassword() async{
    if(_isenviandopass) return;
    setState(() {
     _isenviandopass = true;
    });

    _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text('Enviando EMAIL'),
    ));
    final form = _fomrkey.currentState;

    if (!form.validate()) {
      setState(() {
       _isenviandopass = false; 
      });
      return;
    }
    form.save();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      _scaffoldkey.currentState.hideCurrentSnackBar();
      _scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text('Revisa tu email para reestablecer contraseña'),
        duration: Duration(seconds: 5),
      ));
    } catch (ex) {
      _scaffoldkey.currentState.hideCurrentSnackBar();
      _scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text(ex.toString()),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'cerrar',
          onPressed: (){
            _scaffoldkey.currentState.hideCurrentSnackBar();
          },
        ),
      ));
    } finally{
      setState(() {
       _isenviandopass = false; 
      });
    }
  }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('ForgotPass'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ScrollConfiguration(
          behavior: HiddenScrollBehavior(),
          child: Form(
            key: _fomrkey,
            child: ListView(
              children: <Widget>[
                FlutterLogo(
                  style: FlutterLogoStyle.markOnly, size: 100.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('Porfavor ingresa tu email'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText:'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val){
                    if (val.isEmpty) {
                      return 'porfavor ingresa un correo';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val){
                    setState(() {
                     _email = val; 
                    });
                  },
                ),
              ],
            )
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _forgotPassword();
        },
        child: Icon(Icons.restore),
      ),
    );
   }
 }