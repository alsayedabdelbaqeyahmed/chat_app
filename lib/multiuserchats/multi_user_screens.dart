import 'package:chatapp/add_friends/add_friends_screen.dart';
import 'package:chatapp/chat_screen/chat_app_bar.dart';
import 'package:chatapp/chat_screen/chat_screen.dart';
import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/constants/userDataModel.dart';
import 'package:chatapp/messeges/userImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MultiUserChats extends StatefulWidget {
  static const routeNames = 'MultiUserChats';
  const MultiUserChats({Key? key}) : super(key: key);

  @override
  State<MultiUserChats> createState() => _MultiUserChatsState();
}

class _MultiUserChatsState extends State<MultiUserChats> {
  UserDataModel? user;

  var db = LocalDataBase.db;
  Future<UserDataModel> userData() async {
    await db.getUserData().then((value) {
      //print(value);
      // value.map((e) {
      //   localUserName = e.username;
      //   localUserPhone = e.userPhone2;
      // });
      user = value;
      return user;
    });
    return user!;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: userData(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: size.height * 0.02,
                    ),
                    child: Column(
                      children: [
                        ChatAppBar(
                          userphone: user!.userPhone2,
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(conUserCollectios)
                              .doc(user!.userPhone2)
                              .collection(conFriendCollection)
                              .snapshots(),
                          builder: (ctx, userData) {
                            if (userData.connectionState ==
                                ConnectionState.waiting) {
                              return Expanded(
                                child: Center(),
                              );
                            }
                            final userName =
                                (userData.data as QuerySnapshot).docs;
                            List? friendsData =
                                userName.map((e) => e.data()).toList();

                            return userName.isEmpty
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Image.asset(
                                            'assets/images/welcome.png',
                                            width: size.height * 0.15,
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.02),
                                        Text(
                                          'Start chating now',
                                          style: TextStyle(
                                            fontSize: size.height * 0.04,
                                            color: textColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (ctx, index) {
                                        // print(index);
                                        // print(friendsData.length);
                                        // print(friendsData);
                                        return InkWell(
                                          onTap: () =>
                                              Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                friendPhone: friendsData[index]
                                                    [conFriendPhone],
                                                userId: friendsData[index]
                                                    [conFriendId],
                                                userName: friendsData[index]
                                                    [conFriendUserName],
                                                currentUserId: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                userphone: user!.userPhone2,
                                              ),
                                            ),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              bottom: size.width * 0.02,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: size.width * 0.02,
                                                  ),
                                                  child: userImage(
                                                    size,
                                                    userName[index]
                                                        [conUserImageUrl],
                                                    false,
                                                    isChat: true,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: size.width * .02),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      //left: size.height * 0.01,
                                                      ),
                                                  child: userName[index][
                                                                  conFriendUserName] ==
                                                              '' ||
                                                          userName[index][
                                                                  conFriendUserName] ==
                                                              null
                                                      ? Text(
                                                          userName[index]
                                                              [conFriendPhone],
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                size.width *
                                                                    0.05,
                                                            // fontWeight: FontWeight.bold
                                                          ),
                                                        )
                                                      : Text(
                                                          userName[index][
                                                              conFriendUserName],
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                size.width *
                                                                    0.05,
                                                            // fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: userName.length,
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
        ),
        onPressed: () =>
            Navigator.of(context).pushNamed(AddFriendScreen.routeName),
      ),
    );
  }
}
