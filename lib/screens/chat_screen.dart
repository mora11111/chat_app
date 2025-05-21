import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final _controller = ScrollController();
  List<Message> messagesList = [];

  static String id = 'ChatScreen';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute
        .of(context)
        ?.settings
        .arguments as String? ?? '';
    // return StreamBuilder<QuerySnapshot>(
    //   stream: messages.orderBy(KCreatedAt, descending: true).snapshots(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       List<Message> messagesList = [];
    //       for (int i = 0; i < snapshot.data!.docs.length; i++) {
    //         messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
    //       }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: KPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              KLogo,
              height: 55,
            ),
            Text(
              'Chat',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(

              listener: (context, state){
                if(state is ChatSuccess){
                  messagesList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email ? ChatBubble(
                      message: messagesList[index],
                    ) : ChatBubbleForFriends(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMessage(message: data, email: email);
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: Duration(milliseconds: 1100),
                  curve: Curves.easeOut,
                );
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: Icon(Icons.send),
                suffixIconColor: KPrimaryColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: KPrimaryColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
