// import 'package:flutter/material.dart';
// import 'package:flutter_application_2/presentation/screens/chatDetailPage.dart';


// class ConversationList extends StatefulWidget{
//   String name;
//   String imageUrl;
//   ConversationList({required this.name,required this.imageUrl});
//   @override
//   _ConversationListState createState() => _ConversationListState();
// }

// class _ConversationListState extends State<ConversationList> {


  


//   @override
//   Widget build(BuildContext context) {
//     return
//    GestureDetector(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(builder: (context){
//           return ChatDetailPage();
//         }));
//       },
//       child: Container(
//         padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 10),
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: Row(
//                 children: <Widget>[
//                   CircleAvatar(
//                     backgroundImage: NetworkImage(widget.imageUrl),
//                     maxRadius: 30,
//                   ),
//                   SizedBox(width: 30,),
//                   Expanded(
//                     child: Container(
//                       color: Colors.transparent,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(widget.name, style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
//                           SizedBox(height: 30,),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }