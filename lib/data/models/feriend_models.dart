import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/domail/entities/friend_entites.dart';
import 'package:chatapp/presentation/style/app_string.dart';

class FreindModels extends FriendEntitity {
  FreindModels({
    required super.chatId,
    required super.friendId,
    required super.friendImage,
    required super.friendName,
    required super.friendPhone,
    required super.userImage,
    required super.userName,
    required super.userPhone,
  });

  Map<String, dynamic> toJson() {
    return {
      AppConstansts.conChatId: super.chatId,
      AppConstansts.conFriendId: super.friendId,
      AppConstansts.conFriendImageUrl: super.friendImage,
      AppConstansts.conFriendUserName: super.friendName,
      AppConstansts.conFriendPhone: super.friendPhone,
      AppConstansts.conUserImageUrl: super.userImage,
      AppConstansts.conuserName: super.userName,
      AppConstansts.conuserPhone: super.userPhone,
    };
  }

  factory FreindModels.fromJson(Map<String, dynamic> json) {
    return FreindModels(
      chatId: json[AppConstansts.conChatId],
      friendId: json[AppConstansts.conFriendId],
      friendImage: json[AppConstansts.conFriendImageUrl],
      friendName: json[AppConstansts.conFriendUserName],
      friendPhone: json[AppConstansts.conFriendPhone],
      userImage: json[AppConstansts.conUserImageUrl],
      userName: json[AppConstansts.conuserName],
      userPhone: json[AppConstansts.conuserPhone],
    );
  }
}
