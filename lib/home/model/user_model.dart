class UserModel {
  String name;
  String imgUrl;
  UserModel({
    required this.name,
    required this.imgUrl,
  });


  factory UserModel.fake(){
    return UserModel(
          name: 'Mirac Ziya Alev',
          imgUrl: 'https://avatars.githubusercontent.com/u/81336051?v=4');
  }
}
