import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:open_ai_chat_bot/presentation/provider/message_provider.dart';
import 'package:open_ai_chat_bot/presentation/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:open_ai_chat_bot/presentation/user_list_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  final HttpLink httpLink = HttpLink(
      'https://renewing-hawk-97.hasura.app/v1/graphql',
      defaultHeaders: {'x-hasura-admin-secret': 'Hapoooli@20290'});

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink as Link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
    ),
  );

  runApp(ChangeNotifierProvider<MessageProvider>(
      create: (BuildContext context) => MessageProvider(), child: ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GraphQLProvider(
          client: client,
          child: MaterialApp(
            home: Directionality(
              textDirection:
              TextDirection.rtl, // تغییر جهت نمایش به راست به چپ
              child: SplashScreen(),
            ),
          ),
        );
      })));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    final PageController _pageController = PageController(initialPage: 0);
    int selected = 0;
    final controller = PageController();
    return Directionality(
      textDirection:
      TextDirection.rtl,
      child: Scaffold(
        body: UserListPage(),
        bottomNavigationBar: StylishBottomBar(

          borderRadius: BorderRadius.all(Radius.circular(16)),
          option: BubbleBarOptions(
            //barStyle: BubbleBarStyle.outlined,
            barStyle: BubbleBarStyle.horizontal,
            bubbleFillStyle: BubbleFillStyle.fill,
            // bubbleFillStyle: BubbleFillStyle.outlined,
            opacity: 0.3,
          ),
          items: [
            BottomBarItem(
              icon: SvgPicture.asset('assets/icons/message.svg'),
              //selectedIcon: const Icon(Icons.house_rounded),
              selectedColor: HexColor('#003A79'),
              unSelectedColor: Colors.grey,
              title: const Text('گفتگوها'),
            ),
            BottomBarItem(
              icon: SvgPicture.asset('assets/icons/user.svg'),
              selectedColor: HexColor('#003A79'),
              unSelectedColor: Colors.grey,
              title: const Text('پروفایل'),
            ),
            BottomBarItem(
              icon: SvgPicture.asset('assets/icons/call.svg'),
              selectedColor: HexColor('#003A79'),
              unSelectedColor: Colors.grey,
              title: const Text('تماس'),
            ),
            BottomBarItem(
              icon: SvgPicture.asset('assets/icons/setting.svg'),
              selectedColor: HexColor('#003A79'),
              unSelectedColor: Colors.grey,
              title: const Text('تنظیمات'),
            ),

          ],
          hasNotch: false,
          elevation: 10,

          fabLocation: StylishBarFabLocation.end,
          currentIndex: selected,
          notchStyle: NotchStyle.square,
          onTap: (index) {
            if (index == selected) return;
            controller.jumpToPage(index);
            setState(() {
              selected = index;
            });
          },
        ),
      ),
    );
  }
}
