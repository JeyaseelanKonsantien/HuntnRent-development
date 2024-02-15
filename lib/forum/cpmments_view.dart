import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hunt_and_rent/forum/widget/comment_widget.dart';

import '../../../base/resizer/fetch_pixels.dart';
import '../../../resources/resources.dart';
import 'model/forum_model.dart';

class CommentsView extends StatelessWidget {
  final ForumChatRoomModel model;
  const CommentsView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: FetchPixels.getPixelHeight(80),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: R.colors.theme,
        title: Text("Comments",
            style: R.textStyle.mediumMetropolis().copyWith(
                color: R.colors.whiteColor,
                fontSize: FetchPixels.getPixelHeight(16))),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: R.colors.whiteColor,
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("forum_comments").where("room_id",isEqualTo: model.roomId).get(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List<QueryDocumentSnapshot> query = snapshot.data!.docs;
            List<PostCommentsModel> postCommentsModel = query.map((e) => PostCommentsModel.fromJson(e.data() as Map<String,dynamic>)).toList();
            return ListView.builder(
              itemCount: postCommentsModel.length,
              itemBuilder: (context, index) {
                return CommentWidget(model: postCommentsModel[index],);
              },);
          } else {
            return Center(child: Text(
              "No Comments Found"
            ));
          }

        },
      ),
    );
  }
}
