import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:open_ai_chat_bot/domain/message_model.dart';
import 'package:open_ai_chat_bot/domain/user_model.dart';
import 'package:open_ai_chat_bot/presentation/provider/message_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:provider/provider.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.myUser, required this.otherUser})
      : super(key: key);
  final User myUser;
  final User otherUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  List<IconData> icons = [
    Icons.reply_rounded,
    Icons.copy,
    Icons.delete_forever,];
  List<String> menuTexts = [
    'Reply',
    'Copy',

    'Delete',
  ];
  int currentOffset = 0;
  bool isPageLoading = false;
  final ScrollController controller = ScrollController();
  List<Message> messages = [];

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      controller.jumpTo(controller.position.maxScrollExtent);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;


    String getChatQueryText = """
query MyQuery {
  messages(
    where: {_or: [{_and: [{sender_id: {_eq: "${widget.otherUser.id}"}}, {receiver_id: {_eq: "${widget.myUser.id}"}}]}, {_and: [{sender_id: {_eq: "${widget.myUser.id}"}}, {receiver_id: {_eq: "${widget.otherUser.id}"}}]}]}
    limit: 10
    offset: ${currentOffset}
    order_by: {created_at: desc}
  ) {
    id
    content
    created_at
    sender_id
    receiver_id
  }
}
""";

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: null,
        body: Query(
            options: QueryOptions(
              document: gql(getChatQueryText),
            ),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                return Center(child: Text(result.exception.toString()));
              }

              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }

              List<Message> temp = [];

              for (final message in result.data?['messages']) {
                Message newMessage = Message.fromJson(message);
                bool idExists = messages.any((msg) => msg.id == newMessage.id);
                if (!idExists) {
                  temp.add(newMessage);
                }

              }

              messages = temp.reversed.toList() + messages;



              FetchMoreOptions opts = FetchMoreOptions(
                // variables: {
                //   'limit': 10,
                //   'offset': currentOffset,
                // },
                updateQuery: (previousResultData, fetchMoreResultData) {
                  final List<dynamic> repos = [
                    ...fetchMoreResultData?['messages'] as List<dynamic>,
                    ...previousResultData?['messages'] as List<dynamic>,
                  ];

                  fetchMoreResultData?['messages'] = repos;

                  return fetchMoreResultData;
                },
              );
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],),
                    child: Row(
                      children: [
                        Expanded(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListTile(
                              leading: Container(
                                width: 44.r,
                                height: 44.r ,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      widget.otherUser.profilePicture ?? ''),
                                ),
                              ),
                              title: Text(widget.otherUser.fullName ?? '',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: HexColor('#000E08')
                                ),),
                              subtitle: Text('1 نفر عضو',
                                style:  TextStyle(
                                    fontSize: 12.sp,
                                    color: HexColor('#797C7B').withOpacity(0.5)
                                ),),
                              trailing: Container(
                                width: 60,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset('assets/icons/videos.svg',width: 24.r,),
                                    SvgPicture.asset('assets/icons/phone.svg',
                                      width: 24.r,),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset('assets/icons/back.svg',
                              width: 24.r,)),
                        SizedBox(width: 12,)

                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Consumer<MessageProvider>(
                            builder: (context, notifier, child) {

                              if (notifier.message != null &&
                                  (notifier.message?.senderId) ==
                                      widget.otherUser.id)
                                Future.delayed(const Duration(milliseconds: 500))
                                    .then((value) {
                                  setState(() {
                                    if(notifier.message!=null)
                                      messages.add(notifier.message!);
                                  });
                                });

                              return Expanded(
                                child: NotificationListener<ScrollNotification>(
                                  onNotification: (notification) {
                                    if (notification is ScrollEndNotification &&
                                        controller.position.pixels <=
                                            controller
                                                .position.minScrollExtent +
                                                20 &&
                                        !result.isLoading) {

                                      if (!result.isLoading) {

                                        fetchMore!(opts);
                                        setState(() {
                                          currentOffset++;
                                        });
                                      }
                                    }
                                    return true;
                                  },
                                  child:ListView(
                                    controller: controller,
                                    children: messages.map((message) {
                                      bool isMyUser =
                                          (message.senderId ?? '') ==
                                              (widget.myUser.id ?? '');
                                      return MenuAnchor(
                                        builder: (BuildContext context,
                                            MenuController controller,
                                            Widget? child) {
                                          return GestureDetector(
                                            onLongPress: () {},
                                            onTap: () {
                                              if (controller.isOpen) {
                                                controller.close();
                                              } else {
                                                controller.open();
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(10.0),
                                              child: Align(
                                                alignment: isMyUser
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                                child: message.image != null
                                                    ? SizedBox(
                                                  width:
                                                  screenWidth * 0.8,
                                                  child: Stack(
                                                    alignment:
                                                    Alignment.center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20),
                                                        child:
                                                        Image.network(
                                                          message.content ??
                                                              '',
                                                          loadingBuilder: (BuildContext
                                                          context,
                                                              Widget
                                                              child,
                                                              ImageChunkEvent?
                                                              loadingProgress) {
                                                            if (loadingProgress ==
                                                                null) {
                                                              // Image has finished loading
                                                              return child;
                                                            } else {
                                                              // Image is still loading, show a CircularProgressIndicator
                                                              return Center();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                    : Stack(
                                                  children: [
                                                    Container(
                                                      width: screenWidth,
                                                      padding: EdgeInsets.only(
                                                          left:
                                                          screenWidth *
                                                              0.02,
                                                          right:
                                                          screenWidth *
                                                              0.02,
                                                          top:
                                                          screenWidth *
                                                              0.02,
                                                          bottom:
                                                          screenWidth *
                                                              0.04),
                                                      child:
                                                      Directionality(
                                                        textDirection: isMyUser
                                                            ? TextDirection
                                                            .rtl
                                                            : TextDirection
                                                            .ltr,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            isMyUser
                                                                ? SizedBox()
                                                                : Container(
                                                              width:
                                                              32.r,
                                                              height:
                                                              32.r,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: isMyUser ? Colors.blueGrey : HexColor('#0FA47F')),

                                                              child: isMyUser
                                                                  ? null
                                                                  : CircleAvatar(
                                                                backgroundImage: NetworkImage(widget.otherUser.profilePicture ?? ''),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Flexible(
                                                              child: Container(

                                                                padding:
                                                                EdgeInsets
                                                                    .all(8),
                                                                decoration:
                                                                BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight: Radius.circular(isMyUser
                                                                          ? 4
                                                                          : 10),
                                                                      topLeft: Radius.circular(isMyUser
                                                                          ? 10
                                                                          : 4),
                                                                      bottomLeft: Radius.circular(
                                                                          10),
                                                                      bottomRight:
                                                                      Radius.circular(10)),
                                                                  color: isMyUser
                                                                      ? HexColor(
                                                                      '#e1f6df')
                                                                      : HexColor(
                                                                      '#F6F6F6'),
                                                                ),
                                                                child:
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                                  children: [
                                                                    Text(
                                                                      message.content ??
                                                                          '',
                                                                      style:
                                                                      TextStyle(
                                                                        color:
                                                                        HexColor('#000E08'),
                                                                        fontSize:
                                                                        12.sp,
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 8,),
                                                                    Row(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                          'assets/icons/check_double.svg',
                                                                          width: 10.r,
                                                                        ),
                                                                        SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Text(
                                                                          message.createdAt?.substring(11, 16) ?? '',
                                                                          textAlign: TextAlign.left,
                                                                          style: TextStyle(
                                                                            color: HexColor('#797C7B'),
                                                                            fontSize: 8.sp,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        menuChildren:
                                        List<MenuItemButton>.generate(
                                          3,
                                              (int index) => MenuItemButton(
                                            onPressed: () {

                                            },
                                            child: menuRow(
                                                icons[index], menuTexts[index]),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 2,
                          width: double.infinity,
                          color: HexColor('#EEFAF8'),
                        ),
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 24),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Mutation(
                                  options: MutationOptions(
                                    document: gql(createMutationText()),
                                    // this is the mutation string you just created
                                    // you can update the cache based on results
                                    update: (GraphQLDataProxy? cache,
                                        QueryResult? result) {
                                      // You don't need to return the cache here
                                      if (result?.hasException ?? false) {
                                        print(
                                            "Mutation Error: ${result?.exception.toString()}");
                                      } else {
                                        print(
                                            "Mutation Result: ${result?.data}");
                                      }
                                    },
                                    onCompleted: (dynamic resultData) {
                                      if (resultData != null) {
                                        Message newMessage = Message.fromJson(
                                            resultData?['insert_messages']
                                            ['returning'][0]);

                                        setState(() {
                                          messages.add(newMessage);
                                        });

                                        Future.delayed(Duration(milliseconds: 200), () {
                                          controller.jumpTo(controller.position.maxScrollExtent);
                                        });

                                      } else {
                                        print("Result Data is null");
                                      }
                                    },
                                  ),
                                  builder: (
                                      RunMutation? runMutation,
                                      QueryResult? result,
                                      ) {
                                    return GestureDetector(
                                        onTap: () async {
                                          final userMessageText =
                                              messageController.text;
                                          messageController.clear();
                                          if (userMessageText.isNotEmpty) {
                                            runMutation!({
                                              'content': userMessageText,
                                              'sender_id': widget.myUser.id,
                                              'receiver_id':
                                              widget.otherUser.id,
                                            });
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/send.svg',
                                          width: 24.r,
                                        ));
                                  },
                                ),
                                SizedBox(width: 24,),
                                Expanded(
                                  flex: 4,
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                      ),
                                      cursorColor: Colors.blueAccent,
                                      controller: messageController,
                                      decoration: InputDecoration(
                                        hintText: "پیام",
                                        hintStyle: TextStyle(
                                            color: HexColor('#797C7B'),
                                            fontSize: 16.sp),
                                        fillColor: HexColor('#F7F7FC'),
                                        filled: true,
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.all(8),

                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(4.0),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16,),

                                Icon(
                                  Icons.add,
                                  color: HexColor('#ADB5BD'),
                                  size: 24.r,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget menuRow(IconData icon, String text) {
    return Container(
      width: 200,
      child: Row(
        children: [
          Icon(
            icon,
            color: HexColor('#747474'),
          ),
          Text(
            text,
            style: TextStyle(color: HexColor('#747474')),
          )
        ],
      ),
    );
  }

  String createMutationText() {
    const String sendMessageMutation = """
mutation MyMutation(\$content: String!, \$sender_id: uuid!, \$receiver_id: uuid!) {
  insert_messages(
    objects: {content: \$content, sender_id: \$sender_id, receiver_id: \$receiver_id}
  ) {
    returning {
      content
      created_at
      receiver_id
      sender_id
      id
    }
  }
}
""";
    return sendMessageMutation;
  }
}
