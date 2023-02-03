import 'package:my_udemy_apps/modules/shope_app/shop_login/shop_login_screen.dart';
import 'package:my_udemy_apps/shared/component/component.dart';
import 'package:my_udemy_apps/shared/network/local/cash_helper.dart';

void Signout(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinsh(context, ShopLoginScreen());
    }
  }); 
}
void printFullText(String text) {
  final Pattern = RegExp('.{1,800}');
                 Pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';
