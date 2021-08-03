import 'package:flutter/material.dart';
import 'package:flutter_laravel/screens/listPromotions.dart';
import 'package:flutter_laravel/screens/login_screen.dart';
import 'package:flutter_laravel/screens/register.dart';
import 'package:flutter_laravel/services/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    String token = await storage.read(key: 'token');
    Provider.of<Auth>(context, listen: false).tryToken(token: token);
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Laravel Auth'),
      ),
      body: Center(
        child: Consumer<Auth>(
          builder: (context, auth, child) {
            if (auth.authenticated) {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => ListProm(auth.token)));
              return ListProm(auth.token);
              // return ListProm();
            } else {
              return Text('not logged in');
              //  return ListProm();
            }
          },
        ),
      ),
      drawer: Drawer(child: Consumer<Auth>(builder: (context, auth, child) {
        if (!auth.authenticated) {
          return ListView(
            children: [
              ListTile(
                title: Text('Login'),
                leading: Icon(Icons.login),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
              ListTile(
                title: Text('register'),
                leading: Icon(Icons.login),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Register()));
                },
              ),
            ],
          );
        } else {
          return ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'my name',
                      // auth.user.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'my email',
                      // auth.user.email,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.logout),
                onTap: () {
                  Provider.of<Auth>(context, listen: false).logout();
                },
              ),
            ],
          );
        }
      })),
    );
  }
}
