import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/chatAIModel.dart';

import 'package:flutter_application_2/widgets/conversationList.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}



class _ChatPageState extends State<ChatPage> {
  List<ChatAI> chatAI = [
    ChatAI(nameAI: "DeepSeek-R1", imageURL: "lib/icons/DeepSeek.jpeg"),
    ChatAI(nameAI: "gpt2", imageURL: "lib/icons/gpt2.jpeg"),
    ChatAI(nameAI: "Llama-3.1-8B-Instruct ", imageURL: "lib/icons/MetaLlama.jpeg"),
    ChatAI(nameAI: "bart-large-cnn ", imageURL: "lib/icons/BartLargeCNN.jpeg"),
    ChatAI(nameAI: "stable-diffusion-xl-refiner-1.0 ", imageURL: "lib/icons/StableDiffusion.jpeg"),
  ]; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text("Добро пожаловать в AIManager!"
                    " Выберите ИИ с которым Вы хотите поговорить.",
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),maxLines: 2),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
            padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                 decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 82, 81, 83)),
                  prefixIcon: Icon(Icons.search,color: const Color.fromARGB(255, 82, 81, 83), size: 20,),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 82, 81, 83)
                    )
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatAI.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),              
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(
                  name: chatAI[index].nameAI,
                  imageUrl: chatAI[index].imageURL,                  
                );
              },
            ),
          ],
        ),
      ),      
    );      
  }
}
