/**
 * Time工具类
 * Create by Songlcy
 */
import 'package:timeago/timeago.dart' as timeago;
import './time_zh_message.dart';

class TimeUtil {

  static initLocaleLanguage() {
    timeago.setLocaleMessages("zh-cn", TimeZhCnMessages());
  }

  static String getTimeago(DateTime time) {
    return timeago.format(time, locale: 'zh-cn');;
  }
}