import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:open_ai_chat_bot/chat_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:open_ai_chat_bot/domain/user_model.dart';
import 'package:open_ai_chat_bot/presentation/provider/message_provider.dart';
import 'package:provider/provider.dart';

import '../domain/message_model.dart';
import 'helper/format_date.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  void setupSubscription(MessageProvider notifier) {
    final WebSocketLink websocketLink = WebSocketLink(
      'ws://renewing-hawk-97.hasura.app/v1/graphql',
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: Duration(seconds: 30),
      ),
    );

    GraphQLClient websocketClient = GraphQLClient(
      link: websocketLink,
      cache: GraphQLCache(),
    );

    final subscriptionText = gql(r'''
subscription MySubscription {
  messages(order_by: {created_at: desc}, limit: 10) {
    id
    receiver_id
    sender_id
    user {
      full_name
    }
    content
    created_at
    userBySenderId {
      full_name
      profile_picture
    }
  }
}

    ''');
    final subscription = websocketClient.subscribe(
      SubscriptionOptions(
        document: subscriptionText,
      ),
    );


    subscription.listen((result) {


      DateTime dateTime = DateTime.parse((result.data?['messages'] as List).first['created_at']);
      bool condition1=!(((result.data?['messages'] as List).first['sender_id']).toString()).contains('c9bb44da-83e3-f02f-f3d0-b99e99367195');

      bool condition2=DateTime.now().difference(dateTime).inSeconds<30;
      if(condition1 && condition2)
        {

          String? userImage=(result.data?['messages'] as List).first['userBySenderId']
          ['profile_picture'];
          AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 10,
                channelKey: 'basic_channel',
                actionType: ActionType.Default,
                title: (result.data?['messages'] as List).first['content'],
                body: (result.data?['messages'] as List).first['userBySenderId']
                ['full_name'],
                largeIcon: userImage == null || userImage.isEmpty ?
                'https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049_640.png':userImage,
              ));
          if (notifier.message == null) {
            notifier.setMessage(Message(
                content: (result.data?['messages'] as List).first['content'],
                senderId: (result.data?['messages'] as List).first['sender_id'],
                receiverId: (result.data?['messages'] as List).first['receiver_id'],
                createdAt: (result.data?['messages'] as List).first['created_at']));
            Future.delayed(const Duration(seconds: 1))
                .then((value) => notifier.cleanMessage());
          }

        }

    });
  }

  @override
  Widget build(BuildContext context) {
    MessageProvider notifier =
        Provider.of<MessageProvider>(context, listen: false);
    setupSubscription(notifier);

    String queryText = """
query MyQuery {
  users_by_pk(id: "c9bb-44da-83e3-f02ff3d0b99e-99367195") {
    full_name
    profile_picture
    id
  }
}
""";
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Query(
            options: QueryOptions(
              document:
                  gql(queryText), // this is the query string you just created
            ),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                return Center(child: Text(result.exception.toString()));
              }

              if (result.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              User user = User.fromJson(result.data?['users_by_pk']);

              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          HexColor('#00004B'),
                          HexColor('#000080')
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  DraggableBottomSheet(
                    minExtent: MediaQuery.of(context).size.height * 0.63,
                    useSafeArea: false,
                    curve: Curves.easeIn,
                    previewWidget: usersList(user),
                    expandedWidget: usersList(user),
                    backgroundWidget: backGroundWidget(user,context),
                    duration: const Duration(milliseconds: 10),
                    maxExtent: MediaQuery.of(context).size.height,
                    onDragging: (pos) {},
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget usersList(User myUser) {
    String queryText = """
 query MyQuery {
  users(
    where: {messagesBySenderId: {receiver_id: {_eq: "c9bb-44da-83e3-f02ff3d0b99e-99367195"}}}
  ) {
    full_name
    id
    profile_picture
    messages(limit: 1, order_by: {created_at: desc}) {
      created_at
      content
    }
  }
}
""";
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Query(
          options: QueryOptions(
            document: gql(queryText),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Center(child: Text(result.exception.toString()));
            }

            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<User> users = [];
            for (final user in result.data?['users']) {
              users.add(User.fromJson(user));
            }

            return Column(
              children: [
                Container(
                  height: 3,
                  width: 30,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: HexColor('#E6E6E6'),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                myUser: myUser,
                                otherUser: users[index],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                            leading: Stack(
                              children: [
                                Container(
                                  width: 56.r,
                                  height: 56.r,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        users[index].profilePicture ?? ''),
                                  ),
                                ),
                                if (/*users[index].isOnline*/ true)
                                  Positioned(
                                    bottom: 6.r,
                                    left: 6.r,
                                    child: Container(
                                      width: 8.r,
                                      height: 8.r,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            title: Text(users[index].fullName ?? '',
                            style: TextStyle(
                              fontSize: 16.sp,color: HexColor('#000E08')
                            ),),
                            subtitle:
                                Text(users[index].messages?.last.content ?? '',
                                  style: TextStyle(
                                      fontSize: 12.sp,color: HexColor('#797C7B').withOpacity(0.5)
                                  ),
                                ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  formatDate(
                                      users[index].messages?.last.createdAt ??
                                          ''),
                                    style: TextStyle(
                                        fontSize: 12.sp,color: HexColor('#797C7B').withOpacity(0.5)
                                    ),
                                ),
                                Container(
                                  width: 22.r,
                                  height: 22.r,
                                  child: /*users[index].hasUnreadMessage*/ true
                                      ? CircleAvatar(
                                          backgroundColor: HexColor('#F04A4C'),
                                          radius: 10,
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                )
                              ],
                            )),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget backGroundWidget(User myUser,BuildContext context) {
    String queryText = """
  query MyQuery {
    users {
      id
      profile_picture
      full_name
    }
  }
""";
    return Query(
        options: QueryOptions(
          document: gql(queryText),
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<User> users = [];
          for (final user in result.data?['users']) {
            users.add(User.fromJson(user));
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: HexColor('#FFFFFF').withOpacity(0.2)),
                        padding: EdgeInsets.all(11),
                        child: SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: 22.r,
                          height: 22.r,
                        )),
                    Container(
                        width: 44.r,
                        height: 44.r,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(myUser.profilePicture ==
                                      null ||
                                  myUser.profilePicture!.isEmpty
                              ? 'https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049_640.png'
                              : myUser.profilePicture!),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12, right: 24),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: users
                          .map((e) => GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                myUser: myUser,
                                otherUser: e,
                              ),
                            ),
                          );
                        },
                            child: Column(
                                  children: [
                                    Container(
                                      width: 58.r,
                                      height: 58.r,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: getRandomColor(),
                                            width: 1.2,
                                          ),
                                          color: Colors.transparent),
                                      padding: EdgeInsets.all(3),
                                      margin: EdgeInsets.symmetric(horizontal: 4),
                                      child: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(e.profilePicture ?? ''),
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Text(
                                      e.fullName ?? '',
                                      style: TextStyle(color: Colors.white,
                                      fontSize: 14.sp),
                                    )
                                  ],
                                ),
                          ))
                          .toList()),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          );
        });
  }

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}


