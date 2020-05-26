import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Email: ${bloc.email}'),
          SizedBox(height: 20.0, width: double.infinity,),
          Text('Password: ${bloc.password}')
        ],
      ),
   );
  }
}