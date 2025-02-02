abstract class SocialStates{}
class SocialInitialStates extends SocialStates{}
class SocialGetUserLoadingStates extends SocialStates{}
class SocialGetUserSuccessStates extends SocialStates{}
class SocialGetUserErrorStates extends SocialStates{
  final String error;
  SocialGetUserErrorStates(this.error);
}
class SocialGetPostsLoadingStates extends SocialStates{}
class SocialGetPostsSuccessStates extends SocialStates{}
class SocialGetPostsErrorStates extends SocialStates{
  final String error;
  SocialGetPostsErrorStates(this.error);
}
class SocialLikePostsSuccessStates extends SocialStates{}
class SocialLikePostsErrorStates extends SocialStates{
  final String error;
  SocialLikePostsErrorStates(this.error);
}
class SocialCommentPostsSuccessStates extends SocialStates{}
class SocialCommentPostsErrorStates extends SocialStates{
  final String error;
  SocialCommentPostsErrorStates(this.error);
}
class SocialChangeBottomNavBarStates extends SocialStates{}
class SocialAddPostState extends SocialStates{}
class GetProfileImageSuccessStates extends SocialStates{}
class GetProfileImageErrorStates extends SocialStates{}
class GetCoverImageSuccessStates extends SocialStates{}
class GetCoverImageErrorStates extends SocialStates{}
class UploadCoverImageSuccessStates extends SocialStates{}
class UploadCoverImageErrorStates extends SocialStates{
  UploadCoverImageErrorStates(String string);
}
class UploadProfileImageSuccessStates extends SocialStates{}
class UploadProfileImageErrorStates extends SocialStates{
  UploadProfileImageErrorStates(String string);
}
class UserUpdateLoadingStates extends SocialStates{}
class UserUpdateErrorStates extends SocialStates{
  UserUpdateErrorStates(String string);
}
//create post
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{
  SocialCreatePostErrorState(String string);
}
class SocialCreatePostSuccessState extends SocialStates{}
class GetNewPostImageErrorStates extends SocialStates{}
class GetNewPostImageSuccessStates extends SocialStates{}
class SocialRemovePostImageState extends SocialStates{}