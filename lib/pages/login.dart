import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba_bd/behaviors/hiddenScrollBehavior.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _fomrkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  String _email;
  String _password;

  bool _islogeando = false;

  _login() async{
    if(_islogeando)return;
    setState(() {
     _islogeando=true; 
    });

    _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text('Logueando usuario'),
    ));
    final form = _fomrkey.currentState;

    if (!form.validate()) {
      setState(() {
       _islogeando = false; 
      });
      return;
    }
    form.save();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/maintabs');
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
       _islogeando = false; 
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,

      appBar: AppBar(
        title: Text('Login'),
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
                  style: FlutterLogoStyle.markOnly,
                  size: 200.0,
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
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
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (val){
                    if (val.isEmpty) {
                      return 'porfavor ingresa una contraseña';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val){
                    setState(() {
                     _password = val; 
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Bienvenido PUTO',
                    style: TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
                  ),
                ),
                FlatButton(
                  child: Text('Olvide mi contraseña'),
                  onPressed: (){
                    Navigator.of(context).pushNamed('/forgotpassword');
                  },
                  textColor: Colors.blueGrey,
                ),
              ],
            ),
          )
        )
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _login();
        },
        child: Icon(Icons.account_circle),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: (){ 
            Navigator.of(context).pop();
          },
          child: Text('Crear cuenta'),
        )
      ],
    );
  }
}