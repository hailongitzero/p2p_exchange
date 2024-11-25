import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          "hello": "Hello",
          "language": "Language",
          "search": "Search Product",
          "selectLanguage": "Select Language",
          "changePassword": "Change Password",
          "settings": "Settings",
          "products": "Products",
          "buy": "Buy",
          "change": "Change",
          "logout": "Logout",
          "loginSuccess": "Login Success",
          "loginFail": "Login Fail",
          "trade": "Trade",
          "addFavoriousSuccess": "Add favorious success",
          "addFavoriousFail": "Add favorious fail"
        },
        "vi_VN": {
          "hello": "Hola",
          "language": "Idioma",
          "search": "Tìm kiếm",
          "selectLanguage": "Chọn ngôn ngữ",
          "changePassword": "Đổi mật khẩu",
          "settings": "Cài đặt",
          "products": "Sản phẩm",
          "buy": "Mua",
          "change": "Đổi",
          "logout": "Đăng xuất"
        }
      };
}
