import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/models.dart';
import '../screens.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/Chat';

  static Route route({required UserMatch userMatch}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: ((context) => ChatScreen(
            userMatch: userMatch,
          )),
    );
  }

  final UserMatch userMatch;
  const ChatScreen({
    super.key,
    required this.userMatch,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ProfileScreen.routeName,
                  arguments: userMatch.matchedUser,
                );
              },
              child: CircleAvatar(
                radius: 15.r,
                backgroundImage:
                    NetworkImage(userMatch.matchedUser.imageUrls[0]),
              ),
            ),
            Text(
              userMatch.matchedUser.name,
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: userMatch.chat != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: userMatch.chat![0].messages.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: userMatch.chat![0].messages[index].senderId ==
                                  1
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                    child: Text(
                                      userMatch
                                          .chat![0].messages[index].message,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15.r,
                                        backgroundImage: NetworkImage(
                                            userMatch.matchedUser.imageUrls[0]),
                                      ),
                                      SizedBox(
                                        width: 5.0.w,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8.0)),
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Text(
                                          userMatch
                                              .chat![0].messages[index].message,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        );
                      }))
                  : const SizedBox(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            height: 75.h,
            child: Row(children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Type here...',
                    contentPadding: EdgeInsets.only(
                      left: 20.0,
                      bottom: 5.0,
                      top: 5.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
