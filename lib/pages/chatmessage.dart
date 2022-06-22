import 'package:chatbot/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatMessage{
  String messageContent = "";
  String messageType = "";
  ChatMessage({required this.messageContent, required this.messageType});
}

List <ChatMessage> mesg =[];

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _ctr = TextEditingController();
  ScrollController _sctr = ScrollController();

  void scrollToEnd() {
    _sctr.animateTo(
      _sctr.position.maxScrollExtent + 100,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> fetchdata(userReply) async {
    await dotenv.load();
    final response = await http.get(Uri.parse("http://api.brainshop.ai/get?bid=${dotenv.env[API]}&key=${dotenv.env[API_KEY]}&uid=${dotenv.env$[USERNAME]}&msg=${userReply}"),
        /*headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        }*/);
    final data = json.decode(response.body);

    setState(() {
      mesg.add(
          ChatMessage(messageContent: data["cnt"], messageType: "receiver"));
    });

    scrollToEnd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //debugShowCheckedModeBanner: false,
      backgroundColor: Colors.green[100],
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'First Crush',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: Colors.red[900],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _sctr,
                physics: const ClampingScrollPhysics(),
                child: Stack(
                  children: <Widget>[
                    ListView.builder(
                      itemCount: mesg.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: (mesg[index].messageType == "receiver"
                              ? EdgeInsets.only(right: 100.0)
                              : EdgeInsets.only(left: 100.0)),
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (mesg[index].messageType == "receiver"
                                ? Alignment.topLeft : Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (mesg[index].messageType == "receiver"
                                    ? Colors.yellow[600] : Colors.blue[600]),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(
                                mesg[index].messageContent,
                                style: TextStyle(
                                    fontSize: 15,
                                    color:(
                                      mesg[index].messageType == "receiver"? Colors.black87: Colors.white
                                    )
                                  ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        onTap: (){
                          scrollToEnd();
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          //errorText: 'Error message',
                          fillColor: Colors.pink[100],
                          hintText: "You were saying....",
                          filled:true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),

                          ),
                        ),
                        controller: _ctr,
                        //focusNode: _myFocusNode,
                      ),
                  ),
                  FloatingActionButton.extended(
                      onPressed: (){
                        if (_ctr.text.length > 0) {
                          setState(() {
                            mesg.add(ChatMessage(
                                messageContent: _ctr.text,
                                messageType: "sender"));
                            scrollToEnd();
                          });
                          //print(_ctr.text);
                          fetchdata(_ctr.text);
                          _ctr.clear();
                        }
                      },
                      splashColor: Colors.blueGrey,
                      backgroundColor: Colors.brown,
                      label: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
