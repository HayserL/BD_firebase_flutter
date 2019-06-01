import 'package:flutter/material.dart';
import 'package:prueba_bd/behaviors/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _fomrkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  String _email;
  String _password;

  bool _isRegistrando = false;

  _register() async{
    if(_isRegistrando)return;
    setState(() {
     _isRegistrando=true; 
    });

    _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text('Registrando usuario'),
    ));
    final form = _fomrkey.currentState;

    if (!form.validate()) {
      setState(() {
       _isRegistrando = false; 
      });
      return;
    }
    form.save();

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
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
       _isRegistrando = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Register'),
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
                )
              ],
            ),
          )
        )
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _register();
        },
        child: Icon(Icons.person_add),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: (){ 
            Navigator.of(context).pushNamed('/login');
          },
          child: Text('Ya tengo una cuenta'),
        )
      ],
    );
  }
}