import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/forum/model/forum_model.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/utils/validator.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';
import '../cpmments_view.dart';

class PostWidget extends StatefulWidget {
  final ForumChatRoomModel model;

  PostWidget({super.key, required this.model});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  TextEditingController commentCT = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isReply = false;
  var locale = 'en';

  String timeUntil(DateTime date) {
    return timeago.format(date, locale: locale, allowFromNow: true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(
            bottom: FetchPixels.getPixelHeight(15),
            left: FetchPixels.getPixelHeight(20),
            right: FetchPixels.getPixelHeight(20),
          ),
          // height: FetchPixels.getPixelHeight(230),
          width: double.infinity,
          decoration: BoxDecoration(
            color: R.colors.containerBG1.withOpacity(0.5),
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("users")
                    .doc(widget.model.createdBy)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userData = snapshot.data!.data();
                    if (userData != null) {
                      return Row(
                        children: [
                          Container(
                            height: FetchPixels.getPixelHeight(45),
                            width: FetchPixels.getPixelWidth(45),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: userData["userImage"] == ""
                                  ? getDecorationAssetImage(
                                      context, R.images.profileImage)
                                  : getDecorationNetworkImage(
                                      context,
                                      userData["userImage"],
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          getHorSpace(FetchPixels.getPixelWidth(10)),
                          Text(
                            userData["userName"],
                            style: R.textStyle.mediumMetropolis().copyWith(
                                  color: R.colors.theme,
                                  fontSize: FetchPixels.getPixelHeight(15),
                                ),
                          ),
                          Spacer(),
                          Text(
                            timeUntil(widget.model.createdAt!.toDate())
                                .toString(),
                            style: R.textStyle.regularMetropolis().copyWith(
                                  color: R.colors.fillColor,
                                  fontSize: FetchPixels.getPixelHeight(9),
                                ),
                          ),
                        ],
                      );
                    }
                  }

                  return Center(
                    child: SizedBox(),
                  );
                },
              ),
              getVerSpace(FetchPixels.getPixelWidth(10)),
              Text(widget.model.postContent!,
                  style: R.textStyle.regularMetropolis().copyWith(
                      color: R.colors.blackColor,
                      fontSize: FetchPixels.getPixelHeight(14))),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("forum_comments")
                      .where("room_id", isEqualTo: widget.model.roomId)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<QueryDocumentSnapshot> query = snapshot.data!.docs;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // getAssetImage(R.images.fireIcon,
                          //     scale: FetchPixels.getPixelHeight(4)),
                          getHorSpace(FetchPixels.getPixelWidth(10)),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("forum_reactions")
                                  .where("post_room_id",
                                      isEqualTo: widget.model.roomId)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                List<QueryDocumentSnapshot> query =
                                    snapshot.data!.docs;
                                List<ReactionsModel> reactions = query
                                    .map((e) => ReactionsModel.fromJson(
                                        e.data() as Map<String, dynamic>))
                                    .toList();
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        if (reactions
                                            .where((element) =>
                                                element.userId ==
                                                auth.userModel.email)
                                            .isEmpty) {
                                          ReactionsModel model = ReactionsModel(
                                            postRoomId: widget.model.roomId,
                                            userId: auth.userModel.email,
                                            postReaction: Reactions.like.name,
                                          );
                                          await FirebaseFirestore.instance
                                              .collection("forum_reactions")
                                              .doc()
                                              .set(model.toJson());
                                        } else {
                                          if (reactions
                                                  .where((element) =>
                                                      element.userId ==
                                                      auth.userModel.email)
                                                  .first
                                                  .postReaction ==
                                              Reactions.like.name) {
                                            await FirebaseFirestore.instance
                                                .collection("forum_reactions")
                                                .where("post_room_id",
                                                    isEqualTo:
                                                        widget.model.roomId)
                                                .where("user_id",
                                                    isEqualTo:
                                                        auth.userModel.email)
                                                .get()
                                                .then((value) {
                                              value.docs.forEach((element) {
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        "forum_reactions")
                                                    .doc(element.id)
                                                    .delete();
                                              });
                                            });
                                          }
                                        }
                                      },
                                      child: getAssetImage(
                                          reactions
                                                  .where((element) =>
                                                      element.userId ==
                                                          auth.userModel
                                                              .email &&
                                                      element.postReaction ==
                                                          Reactions.like.name)
                                                  .isNotEmpty
                                              ? R.images.fillLike
                                              : R.images.like,
                                          scale: FetchPixels.getPixelHeight(4)),
                                    ),
                                    getHorSpace(FetchPixels.getPixelWidth(10)),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: FetchPixels.getPixelHeight(15)),
                                      child: InkWell(
                                        onTap: () async {
                                          if (reactions
                                              .where((element) =>
                                                  element.userId ==
                                                      auth.userModel.email &&
                                                  element.postReaction ==
                                                      Reactions.like.name)
                                              .isEmpty) {
                                            if (reactions
                                                .where((element) =>
                                                    element.userId ==
                                                    auth.userModel.email)
                                                .isEmpty) {
                                              ReactionsModel model =
                                                  ReactionsModel(
                                                postRoomId: widget.model.roomId,
                                                userId: auth.userModel.email,
                                                postReaction:
                                                    Reactions.dislike.name,
                                              );
                                              await FirebaseFirestore.instance
                                                  .collection("forum_reactions")
                                                  .doc()
                                                  .set(model.toJson());
                                            } else {
                                              if (reactions
                                                      .where((element) =>
                                                          element.userId ==
                                                          auth.userModel.email)
                                                      .first
                                                      .postReaction ==
                                                  Reactions.dislike.name) {
                                                await FirebaseFirestore.instance
                                                    .collection(
                                                        "forum_reactions")
                                                    .where("post_room_id",
                                                        isEqualTo:
                                                            widget.model.roomId)
                                                    .where("user_id",
                                                        isEqualTo: auth
                                                            .userModel.email)
                                                    .get()
                                                    .then((value) {
                                                  value.docs.forEach((element) {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            "forum_reactions")
                                                        .doc(element.id)
                                                        .delete();
                                                  });
                                                });
                                              }
                                            }
                                          } else {
                                            await FirebaseFirestore.instance
                                                .collection("forum_reactions")
                                                .where("post_room_id",
                                                    isEqualTo:
                                                        widget.model.roomId)
                                                .where("user_id",
                                                    isEqualTo:
                                                        auth.userModel.email)
                                                .get()
                                                .then((value) {
                                              value.docs.forEach((element) {
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        "forum_reactions")
                                                    .doc(element.id)
                                                    .delete();
                                              });
                                            });
                                            ReactionsModel model =
                                                ReactionsModel(
                                              postRoomId: widget.model.roomId,
                                              userId: auth.userModel.email,
                                              postReaction:
                                                  Reactions.dislike.name,
                                            );
                                            await FirebaseFirestore.instance
                                                .collection("forum_reactions")
                                                .doc()
                                                .set(model.toJson());
                                          }
                                        },
                                        child: getAssetImage(
                                            reactions
                                                    .where((element) =>
                                                        element.userId ==
                                                            auth.userModel
                                                                .email &&
                                                        element.postReaction ==
                                                            Reactions
                                                                .dislike.name)
                                                    .isNotEmpty
                                                ? R.images.fillDislike
                                                : R.images.dislike,
                                            scale:
                                                FetchPixels.getPixelHeight(4)),
                                      ),
                                    ),
                                  ],
                                );
                              })

                          // getHorSpace(FetchPixels.getPixelWidth(85)),
                          ,
                          Spacer(),
                          //Text("5k Views",
                              //style: R.textStyle.regularMetropolis().copyWith(
                                  //color: R.colors.blackColor,
                                  //fontSize: FetchPixels.getPixelHeight(14))),
                          getHorSpace(FetchPixels.getPixelWidth(10)),
                          InkWell(
                            onTap: () {
                              Get.to(() => CommentsView(
                                    model: widget.model,
                                  ));
                              isReply = false;
                              FocusScope.of(context).unfocus();
                              setState(() {});
                            },
                            child: Text("${query.length} Comments",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    color: R.colors.blackColor,
                                    fontSize: FetchPixels.getPixelHeight(12))),
                          ),
                          getHorSpace(FetchPixels.getPixelWidth(5)),
                          Icon(Icons.bookmark,
                              color: R.colors.theme,
                              size: FetchPixels.getPixelHeight(28)),
                          SizedBox(
                            width: FetchPixels.getPixelWidth(20),
                            child: PopupMenuButton(
                              padding: EdgeInsets.zero,

                              icon: Icon(Icons.more_horiz_rounded,
                                  color: R.colors.theme,
                                  size: FetchPixels.getPixelHeight(30)),
                              onSelected: (value) {
                                print(value);
                                // your logic
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    // enabled: false,
                                    onTap: () {
                                      isReply = true;
                                      setState(() {});
                                    },
                                    child: Text("Reply to Comment"),
                                    // value: '/hello',
                                  ),
                                  PopupMenuItem(
                                    child: Text("Report"),
                                  ),
                                  PopupMenuItem(
                                    child: Text("Hide"),
                                    value: '/contact',
                                  ),
                                  PopupMenuItem(
                                    child: Text("Mute"),
                                    value: '/contact',
                                  ),
                                ];
                              },

                              // itemBuilder: (BuildContext bc) {

                              // },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: SizedBox(),
                      );
                    }
                  }),
              isReply
                  ? getPaddingWidget(
                      EdgeInsets.only(left: FetchPixels.getPixelWidth(30)),
                      Column(
                        children: [
                          FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.model.createdBy)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: [
                                    Container(
                                      height: FetchPixels.getPixelHeight(45),
                                      width: FetchPixels.getPixelWidth(45),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: getDecorationNetworkImage(
                                            context,
                                            auth.userModel.userImage ?? "",
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    getHorSpace(FetchPixels.getPixelWidth(10)),
                                    Text(auth.userModel.userName ?? "userName",
                                        // snapshot.data!.data()!["userName"],
                                        style: R.textStyle
                                            .mediumMetropolis()
                                            .copyWith(
                                                color: R.colors.theme,
                                                fontSize:
                                                    FetchPixels.getPixelHeight(
                                                        15))),
                                    Spacer(),
                                    Text(
                                        timeUntil(widget.model.createdAt!
                                                .toDate())
                                            .toString(),
                                        style: R.textStyle
                                            .regularMetropolis()
                                            .copyWith(
                                                color: R.colors.fillColor,
                                                fontSize:
                                                    FetchPixels.getPixelHeight(
                                                        9))),
                                  ],
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(10)),
                          Form(
                            key: formKey,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: commentCT,
                                    cursorColor: R.colors.theme,
                                    validator: (value) =>
                                        FieldValidator.validateEmptyField(
                                            value),
                                    maxLines: null,
                                    style: R.textStyle
                                        .regularMetropolis()
                                        .copyWith(
                                            fontSize:
                                                FetchPixels.getPixelHeight(14),
                                            color: R.colors.blackColor),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical:
                                                FetchPixels.getPixelHeight(10),
                                            horizontal:
                                                FetchPixels.getPixelWidth(20)),
                                        isDense: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(20)),
                                          borderSide: BorderSide(
                                            width: 0.5,
                                            color: R.colors.theme,
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(10)),
                                          borderSide: BorderSide(
                                              width: 0.5,
                                              color: R.colors.transparent
                                                  .withOpacity(0.28)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(10)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: R.colors.transparent
                                                  .withOpacity(0.28)),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0.5,
                                            color: R.colors.transparent
                                                .withOpacity(0.28),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(10)),
                                        ),
                                        // border: InputBorder.none,
                                        filled: true,
                                        fillColor: R.colors.fillColor,
                                        focusColor: R.colors.theme,
                                        hintText: "Write here... ",
                                        hintStyle: R.textStyle
                                            .regularMetropolis()
                                            .copyWith(
                                                fontSize:
                                                    FetchPixels.getPixelHeight(
                                                        12),
                                                color: R.colors.blackColor)

                                        //  border: OutlineInputBorder()
                                        ),
                                  ),
                                ),
                                getHorSpace(FetchPixels.getPixelWidth(10)),
                                InkWell(
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      PostCommentsModel postCommentModel =
                                          PostCommentsModel(
                                        roomId: widget.model.roomId,
                                        createdAt: Timestamp.now(),
                                        doc_id: "",
                                        message: commentCT.text,
                                        senderId: auth.userModel.email,
                                        type: 0,
                                      );
                                      isReply = false;
                                      commentCT.clear();

                                      await FirebaseFirestore.instance
                                          .collection("forum_comments")
                                          .add(postCommentModel.toJson())
                                          .then((value) async {
                                        await FirebaseFirestore.instance
                                            .collection("forum_comments")
                                            .doc(value.id)
                                            .update({"doc_id": value.id});
                                      }).then((value) =>
                                              Get.to(() => CommentsView(
                                                    model: widget.model,
                                                  )));

                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        FetchPixels.getPixelHeight(5)),
                                    // height: FetchPixels.getPixelHeight(10),
                                    // width: FetchPixels.getPixelWidth(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: R.colors.theme,
                                    ),
                                    child: Icon(
                                      Icons.send,
                                      color: R.colors.whiteColor,
                                      size: FetchPixels.getPixelHeight(20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
