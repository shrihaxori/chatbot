import 'package:flutter/material.dart';
import 'package:chatbot/pages/chatmessage.dart';
import 'dart:convert';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      
      //height: size.height,
      backgroundColor: Colors.pink[200],
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/catschat.gif',
                height: 250,
                width: 600,
              ),
              SizedBox(
                height: 50,
              ),
              FloatingActionButton.extended(
                onPressed: (){
                  onButtonClicked(context);
                },
                splashColor: Colors.blueGrey,
                backgroundColor: Colors.blueAccent,
                label: Text('Talk to Me'),
              ),
          ],
        ),
        /*
        children: [
          Container(
            child: Text('An App that talks to you'),
          ),
          //Text('Hey, There'),
          FloatingActionButton.extended(
              onPressed: (){
                onButtonClicked(context);
              },
              splashColor: Colors.blueGrey,
              backgroundColor: Colors.blueAccent,
              label: Text('Talk to Me'),
          ),
        ],*/
      ),
    );
  }
}

void onButtonClicked(BuildContext context) {
  //StoreProvider.of<AppState>(context).dispatch(FetchdataAction(message: 'hi'));
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => ChatPage(),
  ));
}