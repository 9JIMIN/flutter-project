import 'package:intl/intl.dart';

String priceFormatter(int intPrice) {
  String rev(str) => str.split('').reversed.join();
  String zeroDelete(str) => int.parse(str).toString();

  String stringPrice = intPrice.toString();
  var f = new NumberFormat('#,###');
  if (stringPrice.length <= 5) {
    // 10만원 미만
    return f.format(intPrice) + '원';
  } else {
    // 10만원 이상이 되면, 억-만 단위를 붙여줌.
    var reversedString = rev(stringPrice);
    // 원
    var won = zeroDelete(rev(reversedString.substring(0, 4)));
    won = won == '0' ? '원' : ' ' + won + '원';

    // 만, 억
    var man = '';
    var ugk = '';
    int len = stringPrice.length;
    if (len >= 9) {
      man = zeroDelete(rev(reversedString.substring(4, 8)));
      ugk = zeroDelete(rev(reversedString.substring(8))) + '억 ';
    } else {
      man = zeroDelete(rev(reversedString.substring(4, len)));
    }
    man = man == '0' ? '' : man + '만';

    return ugk + man + won;
  }
}
