import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/domain/entities/notification_entity.dart';
import 'package:qibla_and_prayer_times/domain/repositories/notification_repository.dart';
import 'package:qibla_and_prayer_times/data/models/notification_model.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  @override
  Future<Either<String, List<NotificationEntity>>> getNotifications() async {
    try {
      // ডেমো ডাটা তৈরি

      return right(notifications);
    } catch (e) {
      return left('নোটিফিকেশন লোড করতে সমস্যা হয়েছে');
    }
  }

  @override
  Future<Either<String, void>> markAsRead(String id) async {
    try {
      // এখানে পরে ডাটাবেস লজিক যুক্ত করা হবে
      return right(null);
    } catch (e) {
      return left('নোটিফিকেশন আপডেট করতে সমস্যা হয়েছে');
    }
  }

  @override
  Future<Either<String, void>> clearAll() async {
    try {
      // এখানে পরে ডাটাবেস লজিক যুক্ত করা হবে
      return right(null);
    } catch (e) {
      return left('নোটিফিকেশন মুছে ফেলতে সমস্যা হয়েছে');
    }
  }
}

final List<NotificationModel> notifications = [
  NotificationModel(
    id: '1',
    title: 'নামাজের সময় হয়েছে',
    description:
        'ফজরের নামাজের সময় হয়েছে। আল্লাহর ইবাদত করার জন্য প্রস্তুত হোন।',
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    type: 'prayer_time',
    actionButtonCallback: () {},
    isRead: false,
    actionUrl: 'https://www.google.com',
    imageUrl: SvgPath.icLovely,
  ),
  NotificationModel(
    id: '2',
    title: 'সেহরির সময়',
    description: 'সেহরির সময় শুরু হয়েছে। রোজা রাখার নিয়ত করুন।',
    timestamp: DateTime.now(),
    type: 'sehri_time',
    isRead: true,
    imageUrl: SvgPath.icNotificationOutline,
  ),
  NotificationModel(
    id: '3',
    title: 'ইফতারের সময়',
    description: 'ইফতারের সময় হয়েছে। আল্লাহর রহমতে রোজা ভাঙ্গার সময় এসেছে।',
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    type: 'iftar_time',
    isRead: false,
    imageUrl: SvgPath.icMusicFill,
  ),
  NotificationModel(
    id: '4',
    title: 'ইফতারের সময়',
    description: "ইফতারের সময় হয়েছে। আল্লাহর রহমতে রোজা ভাঙ্গার সময় এসেছে।",
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    type: 'iftar_time',
    isRead: false,
    imageUrl: SvgPath.icCategoryFill,
  ),
  NotificationModel(
    id: '5',
    title: 'ইফতারের সময়',
    description: "ইফতারের সময় হয়েছে। আল্লাহর রহমতে রোজা ভাঙ্গার সময় এসেছে।",
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    type: 'iftar_time',
    isRead: false,
    imageUrl: SvgPath.icCrown,
  ),
];
