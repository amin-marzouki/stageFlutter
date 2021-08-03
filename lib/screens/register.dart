import 'package:flutter/material.dart';
import 'package:flutter_laravel/services/auth.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<Register> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController.text = 'amin@gmail.com';
    _passwordController.text = 'password';
    _nameController.text = 'name';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  controller: _emailController,
                  validator: (value) =>
                      value.isEmpty ? 'please enter valid email' : null),
              TextFormField(
                  controller: _nameController,
                  validator: (value) =>
                      value.isEmpty ? 'please enter name' : null),
              TextFormField(
                  controller: _passwordController,
                  validator: (value) =>
                      value.isEmpty ? 'please enter password' : null),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                minWidth: double.infinity,
                color: Colors.blue,
                child: Text('register', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Map creds = {
                    'email': _emailController.text,
                    'name': _nameController.text,
                    'password': _passwordController.text,
                    // 'device_name': 'mobile',
                  };
                  if (_formKey.currentState.validate()) {
                    Provider.of<Auth>(context, listen: false)
                        .register(creds: creds);
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
