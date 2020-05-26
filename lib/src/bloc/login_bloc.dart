import 'dart:async';

import 'package:formvalidation/src/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  dispose() { 
    _emailController?.close();
    _passwordController?.close();
  }

  //Recuperar los datos del stream
  Stream<String>get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String>get passwordStream => _passwordController.stream.transform(validarPassword);
  
  Stream<bool> get formValidStream =>  CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al stream
  Function(String)get changeEmail => _emailController.sink.add;
  Function(String)get changePassword => _passwordController.sink.add;

  // OBTENER ULTIMO VALOR INGRESADO A LOS STREAMS
  String get email => _emailController.value;
  String get password => _passwordController.value;

}