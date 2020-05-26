import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(size, context),
          _loginForm(size, context)
        ],
      ),
    );
  }

  _crearFondo(Size size, BuildContext context) {
    final _fondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );
    final _circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white.withOpacity(0.15)),
    );
    return Stack(
      children: <Widget>[
        _fondo,
        Positioned(top: 90.0, left: 30.0, child: _circulo),
        Positioned(top: -40.0, right: -30.0, child: _circulo),
        Positioned(top: size.height * 0.34, right: -10.0, child: _circulo),
        Positioned(top: 130.0, right: 20.0, child: _circulo),
        Positioned(top: size.height * 0.33, left: -20.0, child: _circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'Sebas palacios',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              )
            ],
          ),
        )
      ],
    );
  }

  _loginForm(Size size, BuildContext context) {
    final bloc = Provider.of(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 180,
          )),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearEmail(size, context, bloc),
                SizedBox(
                  height: 30.0,
                ),
                _crearPassword(size, context, bloc),
                SizedBox(
                  height: 30.0,
                ),
                _crearBoton(size, context, bloc)
              ],
            ),
          ),
          Text('¿Olvido la contraseña?'),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  _crearEmail(Size size, BuildContext context, LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.alternate_email,
                    color: Colors.deepPurple,
                  ),
                  hintText: 'ejemplo@correo.com',
                  labelText: 'correo electrónico',
                  counterText: snapshot.data,
                  errorText: snapshot.error),
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  _crearPassword(Size size, BuildContext context, LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.deepPurple,
                  ),
                  hintText: 'Contraseña',
                  counterText: snapshot.data,
                  errorText: snapshot.error),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

  _crearBoton(Size size, BuildContext context, LoginBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.formValidStream,
        builder: (context, snapshot) {
          return RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 0.0,
              color: Colors.deepPurple,
              textColor: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
                child: Text('Ingresar'),
              ),
              onPressed: snapshot.hasData ? () => _login(bloc, context) : null);
        });
  }

  _login(LoginBloc bloc, BuildContext context){
    print('=====================');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    print('=====================');

    Navigator.pushReplacementNamed(context, 'home');
  }
}
