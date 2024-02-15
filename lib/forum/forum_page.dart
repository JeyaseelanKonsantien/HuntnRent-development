import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/forum/model/forum_model.dart';
import 'package:hunt_and_rent/forum/widget/post_widget.dart';
import 'package:hunt_and_rent/screens/auth/model/user_model.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../resources/resources.dart';

class ForumView extends StatefulWidget {
  ForumChatRoomModel? forumRoomData;
  final String? peerEmail;
  UsersModel? userModel;

  ForumView({super.key, this.userModel, this.forumRoomData, this.peerEmail});

  @override
  State<ForumView> createState() => _ForumViewState();
}

class _ForumViewState extends State<ForumView> {
  TextEditingController postCT = TextEditingController();
  int selectedHeadings = 0;
  List<String> text = [
    "B",
    "U",
    "I",
  ];
  List<String> headings = [
    "Recent",
    //"Popular",
    //"Featured",
    //"Most Replied",
  ];

  bool isChecked = false;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("forum_room_chat")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    List<QueryDocumentSnapshot> query = snapshot.data!.docs;
                    List<ForumChatRoomModel> forumChatRoomModel = query
                        .map((e) => ForumChatRoomModel.fromJson(
                            e.data() as Map<String, dynamic>))
                        .toList();
                    return ListView(
                      children: [
                        getVerSpace(FetchPixels.getPixelWidth(10)),
                        Row(
                          children: [
                            getHorSpace(FetchPixels.getPixelWidth(20)),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                size: FetchPixels.getPixelWidth(25),
                              ),
                            ),
                            getHorSpace(FetchPixels.getPixelWidth(20)),
                            Expanded(
                              child: Text(
                                "Discussion Forum",
                                style: R.textStyle.mediumMetropolis().copyWith(
                                    color: R.colors.blackColor,
                                    fontSize: FetchPixels.getPixelHeight(22)),
                              ),
                            ),
                            IconButton.outlined(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) => Container(
                                        height: FetchPixels.getPixelHeight(500),
                                        padding: EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            getPaddingWidget(
                                              EdgeInsets.only(
                                                  left:
                                                      FetchPixels.getPixelWidth(
                                                          20),
                                                  right:
                                                      FetchPixels.getPixelWidth(
                                                          20)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text("Create new forum",
                                                      style: R.textStyle
                                                          .semiBoldMetropolis()
                                                          .copyWith(
                                                              color: R.colors
                                                                  .blackColor,
                                                              fontSize: FetchPixels
                                                                  .getPixelHeight(
                                                                      16))),
                                                  Spacer(),
                                                  SizedBox(
                                                    height: FetchPixels
                                                        .getPixelHeight(20),
                                                    width: FetchPixels
                                                        .getPixelWidth(20),
                                                    child: Checkbox(
                                                      activeColor:
                                                          R.colors.theme,
                                                      value: isChecked,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isChecked =
                                                              !isChecked;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  getHorSpace(
                                                      FetchPixels.getPixelWidth(
                                                          10)),
                                                  Text("Anonymous Post",
                                                      style: R.textStyle
                                                          .regularMetropolis()
                                                          .copyWith(
                                                              color: R.colors
                                                                  .blackColor,
                                                              fontSize: FetchPixels
                                                                  .getPixelHeight(
                                                                      13))),
                                                ],
                                              ),
                                            ),
                                            getVerSpace(
                                                FetchPixels.getPixelWidth(20)),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      FetchPixels.getPixelWidth(
                                                          15)),
                                              width: FetchPixels.width,
                                              decoration: BoxDecoration(
                                                color: R.colors.containerBG,
                                                borderRadius: BorderRadius
                                                    .circular(FetchPixels
                                                        .getPixelHeight(10)),
                                              ),
                                              child: Column(
                                                children: [
                                                  getVerSpace(
                                                      FetchPixels.getPixelWidth(
                                                          5)),
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "enter some text";
                                                      }
                                                    },
                                                    controller: postCT,
                                                    cursorColor:
                                                        R.colors.blackColor,
                                                    maxLines: 5,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Please post your comment, or any feedback. ",
                                                        hintStyle: R.textStyle
                                                            .regularMetropolis()
                                                            .copyWith(
                                                                fontSize:
                                                                    FetchPixels
                                                                        .getPixelHeight(
                                                                            13),
                                                                color: R.colors
                                                                    .blackColor
                                                                    .withOpacity(
                                                                        0.5))),
                                                  ),
                                                  getVerSpace(
                                                      FetchPixels.getPixelWidth(
                                                          20)),
                                                ],
                                              ),
                                            ),
                                            getVerSpace(
                                                FetchPixels.getPixelWidth(10)),
                                            Align(
                                              alignment: Alignment.center,
                                              child: getPaddingWidget(
                                                EdgeInsets.only(
                                                    right: FetchPixels
                                                        .getPixelWidth(10)),
                                                InkWell(
                                                  onTap: () async {
                                                    if (postCT.text != '') {
                                                      print(postCT.text);
                                                      ForumChatRoomModel
                                                          chatRoom =
                                                          ForumChatRoomModel(
                                                        createdAt:
                                                            Timestamp.now(),
                                                        createdBy: auth
                                                            .userModel.email,
                                                        postContent:
                                                            postCT.text,
                                                        peerId:
                                                            "admin@admin.com",
                                                        roomId: "",
                                                      );
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "forum_room_chat")
                                                          .add(
                                                              chatRoom.toJson())
                                                          .then((value) async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "forum_room_chat")
                                                            .doc(value.id)
                                                            .update({
                                                          "room_id": value.id
                                                        });
                                                      });
                                                      // PostDataModel chatData = PostDataModel(
                                                      //     message: postCT.text,
                                                      //     roomId: widget.forumRoomData.roomId,
                                                      //     senderId: auth.userModel!.email,
                                                      //     receiverId:"",
                                                      //     type: 0,
                                                      //     isSeen: false,
                                                      //     createdAt: Timestamp.now());
                                                      // postCT.clear();
                                                      //
                                                      // await FirebaseFirestore.instance.collection("forum").doc().set(chatData.toJson());
                                                      // setState(() {});
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          500),
                                                                  content: Text(
                                                                    'Please Write Something',
                                                                  )));
                                                    }
                                                    postCT.clear();
                                                    Get.snackbar("Alert!",
                                                        "Your Post is Added Successfully!");
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        vertical: FetchPixels
                                                            .getPixelWidth(15)),
                                                    height: FetchPixels
                                                        .getPixelHeight(40),
                                                    width: FetchPixels
                                                        .getPixelWidth(160),
                                                    decoration: BoxDecoration(
                                                      color: R.colors.theme,
                                                      borderRadius: BorderRadius
                                                          .circular(FetchPixels
                                                              .getPixelHeight(
                                                                  5)),
                                                    ),
                                                    child: Center(
                                                      child: Text("Save & Post",
                                                          style: R.textStyle
                                                              .mediumMetropolis()
                                                              .copyWith(
                                                                  color: R
                                                                      .colors
                                                                      .whiteColor,
                                                                  fontSize: FetchPixels
                                                                      .getPixelHeight(
                                                                          15))),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: R.colors.g1,
                                )),
                            getHorSpace(FetchPixels.getPixelWidth(20)),
                          ],
                        ),
                        getVerSpace(FetchPixels.getPixelWidth(20)),
                        Padding(
                          padding: EdgeInsets.only(
                              left: FetchPixels.getPixelWidth(20),
                              right: FetchPixels.getPixelWidth(10)),
                          child: TextFormField(
                            controller: searchController,
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                            decoration: R.decorations
                                .textFormFieldDecoration(null, "Search",
                                    suffix: searchController.text == ""
                                        ? Icon(Icons.search_rounded)
                                        : InkWell(
                                            onTap: () {
                                              searchController.clear();
                                              searchQuery = "";
                                              setState(() {});
                                            },
                                            child: Icon(Icons.clear))),
                          ),
                        ),
                        getVerSpace(FetchPixels.getPixelWidth(20)),
                        SizedBox(
                          height: FetchPixels.getPixelHeight(40),
                          child: ListView.builder(
                            itemCount: headings.length,
                            padding: EdgeInsets.symmetric(
                                horizontal: FetchPixels.getPixelWidth(10)),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return title(index, context);
                            },
                          ),
                        ),
                        getVerSpace(FetchPixels.getPixelWidth(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: FetchPixels.getPixelHeight(0.75),
                              width: FetchPixels.getPixelWidth(140),
                              decoration: BoxDecoration(
                                color: R.colors.theme,
                              ),
                            ),
                            Text("1 July 2023",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    color: R.colors.theme,
                                    fontSize: FetchPixels.getPixelHeight(13))),
                            Container(
                              height: FetchPixels.getPixelHeight(0.75),
                              width: FetchPixels.getPixelWidth(140),
                              decoration: BoxDecoration(
                                color: R.colors.theme,
                              ),
                            ),
                          ],
                        ),
                        getVerSpace(FetchPixels.getPixelWidth(10)),
                        Column(
                          children:
                              List.generate(forumChatRoomModel.length, (index) {
                            return PostWidget(
                              model: forumChatRoomModel[index],
                            );
                          }),
                        ),
                        getVerSpace(FetchPixels.getPixelWidth(10)),
                        // getPaddingWidget(
                        //   EdgeInsets.only(right: FetchPixels.getPixelWidth(10)),
                        //   Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       SizedBox(
                        //         height: FetchPixels.getPixelHeight(20),
                        //         width: FetchPixels.getPixelWidth(20),
                        //         child: Checkbox(
                        //           activeColor: R.colors.theme,
                        //           value: isChecked,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               isChecked = !isChecked;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //       getHorSpace(FetchPixels.getPixelWidth(10)),
                        //       Text("Anonymous Post",
                        //           style: R.textStyle
                        //               .regularMetropolis()
                        //               .copyWith(
                        //                   color: R.colors.blackColor,
                        //                   fontSize:
                        //                       FetchPixels.getPixelHeight(13))),
                        //     ],
                        //   ),
                        // ),
                        // getVerSpace(FetchPixels.getPixelWidth(10)),
                        // Container(
                        //   padding: EdgeInsets.all(10),
                        //   margin: EdgeInsets.symmetric(
                        //       horizontal: FetchPixels.getPixelWidth(15)),
                        //   width: FetchPixels.width,
                        //   decoration: BoxDecoration(
                        //     color: R.colors.containerBG,
                        //     borderRadius: BorderRadius.circular(
                        //         FetchPixels.getPixelHeight(10)),
                        //   ),
                        //   child: Column(
                        //     children: [
                        //       getVerSpace(FetchPixels.getPixelWidth(5)),
                        //       TextFormField(
                        //         controller: postCT,
                        //         cursorColor: R.colors.blackColor,
                        //         maxLines: 5,
                        //         decoration: InputDecoration(
                        //             border: InputBorder.none,
                        //             hintText:
                        //                 "Please post your comment, or any feedback. ",
                        //             hintStyle: R.textStyle
                        //                 .regularMetropolis()
                        //                 .copyWith(
                        //                     fontSize:
                        //                         FetchPixels.getPixelHeight(13),
                        //                     color: R.colors.blackColor
                        //                         .withOpacity(0.5))),
                        //       ),
                        //       getVerSpace(FetchPixels.getPixelWidth(20)),
                        //     ],
                        //   ),
                        // ),
                        // getVerSpace(FetchPixels.getPixelWidth(10)),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: getPaddingWidget(
                        //     EdgeInsets.only(
                        //         right: FetchPixels.getPixelWidth(10)),
                        //     InkWell(
                        //       onTap: () async {
                        //         if (postCT.text != '') {
                        //           print(postCT.text);
                        //           ForumChatRoomModel chatRoom =
                        //               ForumChatRoomModel(
                        //             createdAt: Timestamp.now(),
                        //             createdBy: auth.userModel.email,
                        //             postContent: postCT.text,
                        //             peerId: "admin@admin.com",
                        //             roomId: "",
                        //           );
                        //           await FirebaseFirestore.instance
                        //               .collection("forum_room_chat")
                        //               .add(chatRoom.toJson())
                        //               .then((value) async {
                        //             await FirebaseFirestore.instance
                        //                 .collection("forum_room_chat")
                        //                 .doc(value.id)
                        //                 .update({"room_id": value.id});
                        //           });
                        //           // PostDataModel chatData = PostDataModel(
                        //           //     message: postCT.text,
                        //           //     roomId: widget.forumRoomData.roomId,
                        //           //     senderId: auth.userModel!.email,
                        //           //     receiverId:"",
                        //           //     type: 0,
                        //           //     isSeen: false,
                        //           //     createdAt: Timestamp.now());
                        //           // postCT.clear();
                        //           //
                        //           // await FirebaseFirestore.instance.collection("forum").doc().set(chatData.toJson());
                        //           // setState(() {});
                        //         } else {
                        //           ScaffoldMessenger.of(context)
                        //               .showSnackBar(SnackBar(
                        //                   duration: Duration(milliseconds: 500),
                        //                   content: Text(
                        //                     'Please Write Something',
                        //                   )));
                        //         }
                        //         postCT.clear();
                        //         Get.snackbar("Alert!",
                        //             "Your Post is Added Successfully!");
                        //       },
                        //       child: Container(
                        //         margin: EdgeInsets.symmetric(
                        //             vertical: FetchPixels.getPixelWidth(15)),
                        //         height: FetchPixels.getPixelHeight(40),
                        //         width: FetchPixels.getPixelWidth(160),
                        //         decoration: BoxDecoration(
                        //           color: R.colors.theme,
                        //           borderRadius: BorderRadius.circular(
                        //               FetchPixels.getPixelHeight(5)),
                        //         ),
                        //         child: Center(
                        //           child: Text("Save & Post",
                        //               style: R.textStyle
                        //                   .mediumMetropolis()
                        //                   .copyWith(
                        //                       color: R.colors.whiteColor,
                        //                       fontSize:
                        //                           FetchPixels.getPixelHeight(
                        //                               15))),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(color: R.colors.theme),
                    );
                  }
                }));
      },
    );
  }

  Widget title(index, BuildContext context) {
    return InkWell(
      onTap: () {
        selectedHeadings = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: FetchPixels.getPixelWidth(10),
            horizontal: FetchPixels.getPixelWidth(10)),
        margin: EdgeInsets.only(right: FetchPixels.getPixelWidth(7)),
        decoration: BoxDecoration(
          color:
              selectedHeadings == index ? R.colors.theme : R.colors.containerBG,
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(5)),
        ),
        child: Center(
          child: Text(headings[index],
              style: R.textStyle.mediumMetropolis().copyWith(
                  color: selectedHeadings == index
                      ? R.colors.whiteColor
                      : R.colors.theme,
                  fontSize: FetchPixels.getPixelHeight(13))),
        ),
      ),
    );
  }
}
