import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hunt_and_rent/screens/auth/model/user_model.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';
import '../model/forum_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentWidget extends StatelessWidget {
  final PostCommentsModel model;
  CommentWidget({super.key,required this.model,});
  var locale = 'en';

  String timeUntil(DateTime date) {
    return timeago.format(date, locale: locale, allowFromNow: true);
  }

  @override
  Widget build(BuildContext context) {
    return  getPaddingWidget(
      EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getVerSpace(FetchPixels.getPixelHeight(10)),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection("users").doc(model.senderId).get(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                UsersModel user = UsersModel.fromJson(snapshot.data!.data());
                return Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: FetchPixels.getPixelHeight(45),
                        width: FetchPixels.getPixelWidth(45),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image:snapshot.data!.data()!["userImage"]==""? getDecorationAssetImage(context, R.images.profileImage): getDecorationNetworkImage(
                            context,snapshot.data!.data()!["userImage"],),
                        ),
                      ),
                      getHorSpace(FetchPixels.getPixelWidth(10)),
                      Expanded(
                        child: Text(user.userName!,
                            style: R.textStyle
                                .mediumMetropolis()
                                .copyWith(
                                color: R.colors.theme,
                                fontSize:
                                FetchPixels.getPixelHeight(
                                    15))),
                      ),
                      Spacer(),
                      Text(
                          timeUntil(
                              model.createdAt!.toDate())
                              .toString(),
                          style: R.textStyle
                              .regularMetropolis()
                              .copyWith(
                              color: R.colors.containerBG,
                              fontSize:
                              FetchPixels.getPixelHeight(
                                  9))),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }

            },
          ),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          Text(model.message!),
          getDivider(R.colors.fillColor.withOpacity(0.2), FetchPixels.getPixelHeight(20),FetchPixels.getPixelHeight(1))
        ],
      ),
    );
  }
}

