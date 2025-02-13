import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';

class ChatDetailPage extends StatefulWidget{
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
    final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  final Logger _logger = Logger();

  Future<void> _sendMessage() async {
    setState(() {
      _isLoading = true;
    });

    final message = _messageController.text;
    try {
      final response = await http.post(
        Uri.parse('https://text.pollinations.ai/'), // URL API для чата с богом
        body: jsonEncode({
          'messages': [
            {'role': 'system', 'content': 'You are a helpful assistant.'},
            {'role': 'user', 'content': message}
          ],
          'model': 'openai',
          'jsonMode': true,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _logger.d('API Response: $data'); // Логирование ответа API

        String godResponse;
        if (data is String) {
          godResponse = data;
        } else if (data is Map<String, dynamic>) {
          godResponse = jsonEncode(data);
        } else {
          godResponse = 'No response';
        }

        setState(() {
          _messages.add({'role': 'user', 'content': message});
          _messages.add({'role': 'god', 'content': godResponse});
        });
        _messageController.clear();
      } else {
        // Обработка ошибки
        _logger.e('Failed to send message: ${response.statusCode}');
        _logger.e('Response body: ${response.body}');
        setState(() {
          _messages.add({'role': 'error', 'content': 'Failed to send message'});
        });
      }
    } catch (e) {
      _logger.e('Exception: $e');
      setState(() {
        _isLoading = false;
        _messages.add({'role': 'error', 'content': 'Exception occurred'});
      });
    }
  }


  @override
  Widget build(BuildContext context) { //Панель приложений для экрана сведений о чате
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage(""),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("DeepSeek-R1",style: TextStyle( fontSize: 20 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                    ],
                  ),
                ),
                Icon(Icons.settings,color: Colors.black54,),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUserMessage = message['role'] == 'user';
                  final isErrorMessage = message['role'] == 'error';
                  return Align(
                    alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Color.fromARGB(255, 181, 144, 249) : Color.fromARGB(255, 205, 198, 214),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        message['content']!,
                        style: TextStyle(
                          color: isErrorMessage ? Colors.red : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align( //Нижнее текстовое поле
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 181, 144, 249),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: _isLoading ? null : _sendMessage,
                    backgroundColor: const Color.fromARGB(255, 181, 144, 249),
                    elevation: 0,
                    child: _isLoading ? const CircularProgressIndicator() : Icon(Icons.send,color: Colors.white,size: 18,),
                  ),
                ],

              ),
            ),
          ),
          ],
        ),
      ),
      

     /* body: Stack( //Дизайн сообщений
        children: <Widget>[
          ListView.builder(     
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return Container(
                padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (messages[index].messageType  == "receiver"?const Color.fromARGB(255, 205, 198, 214):const Color.fromARGB(255, 181, 144, 249)),
                    ),
                  padding: EdgeInsets.all(16),
                  child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
                  ),
                ),
              );
            },
          ),
          Align( //Нижнее текстовое поле
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 181, 144, 249),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: _isLoading ? null : _sendMessage,
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: const Color.fromARGB(255, 181, 144, 249),
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),*/
    );
  }
}

