import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quick_messenger/components/circular_border_button.dart';
import 'package:quick_messenger/components/getterLabel.dart';
import 'package:quick_messenger/components/input.dart';
import 'package:quick_messenger/components/senderLabel.dart';
import 'package:quick_messenger/services/message.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late Message message;
  final _auth = FirebaseAuth.instance;
  late User loggedUser;
  bool loading = false;

  String messageText = "";

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handleLogout() async {
    try {
      await _auth.signOut();
      if (!context.mounted) {
        return;
      }
      Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handleSendMessage() async {
    setState(() { loading = true; });
    await message.sendMessage(
      text: messageText,
      sender: loggedUser.email!
    );
    setState(() { loading = false; });
  }

  @override
  void initState() {
    super.initState();
    message = Message();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black87,
          ),
          backgroundColor: Colors.amber,
          title: const Text(
            "Quick Messenger",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: handleLogout,
                child: const Icon(
                  Icons.close,
                  color: Colors.black87,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: message.getMessageSnapshot(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if (snapshot.hasData) {
                        List<Widget> messageList = [];
                        final messages = snapshot.data?.docs;
                        for(var message in messages!){
                          String text = message["text"];
                          String sender = message["sender"];
                          if(sender == loggedUser.email){
                            messageList.add(SenderLabel(text: text));
                          } else {
                            messageList.add(GetterLabel(text: text, sender: sender));
                          }
                        }
                        return ListView(
                          reverse: true,
                          children: messageList,
                        );
                      }
                      return const Text("No data");
                    },
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomInput(
                        onChanged: (e) {
                          messageText = e.toString();
                        },
                        color: Colors.amber,
                        placeholder: "Type something...",
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircularBorderButton(
                      buttonColor: Colors.amber,
                      buttonTitle: "Send",
                      onTap: handleSendMessage,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
                  GestureDetector(
                    onTap: handleSendMessage,
                    child: const Text(
                      "Send",
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
 */
