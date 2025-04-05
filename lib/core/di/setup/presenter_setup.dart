import 'package:get_it/get_it.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/di/setup/setup_module.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/contact_us/presenter/contact_us_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/event/pesenter/event_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/main_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/menu_drawer_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/notification/presenter/notification_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/onboarding/presenter/onboarding_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/home/presenter/home_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/event/pesenter/ramadan_calendar_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/settings/presenter/settings_page_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/support_us/presenter/support_us_presenter.dart';

class PresenterSetup implements SetupModule {
  final GetIt _serviceLocator;
  PresenterSetup(this._serviceLocator);

  @override
  Future<void> setup() async {
    _serviceLocator
      ..registerFactory(() => loadPresenter(MainPresenter(locate())))
      ..registerLazySingleton(() => loadPresenter(PrayerTrackerPresenter(
          locate(), locate(), locate(), locate(), locate(), locate())))
      ..registerLazySingleton(() => loadPresenter(SettingsPagePresenter(
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(
          () => loadPresenter(OnboardingPresenter(locate(), locate())))
      ..registerLazySingleton(
          () => loadPresenter(NotificationPresenter(locate())))
      ..registerLazySingleton(() => loadPresenter(ContactUsPresenter()))
      ..registerLazySingleton(() => loadPresenter(SupportUsPresenter(
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(RamadanCalendarPresenter(
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(HomePresenter(
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(MenuDrawerPresenter()))
      ..registerLazySingleton(() => loadPresenter(EventPresenter()));
  }
}
