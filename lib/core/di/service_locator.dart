// Implementation Note:
//
// The app utilizes the **Service Locator Pattern** to manage dependencies.
//
// The Service Locator Pattern is a design pattern that improves modularity and
// maintainability in our codebase. By decoupling the code from direct dependency
// references, it allows for easier substitution or addition of dependencies in
// the future.
//
// To understand the Service Locator Pattern in more detail, you can refer to
// the following resource: https://stackify.com/service-locator-pattern/.
//
// This pattern simplifies the process of replacing or adding dependencies.
// Instead of modifying every object that relies on a particular dependency, we
// only need to update the service locator itself. This centralization reduces
// code changes and minimizes potential errors.
import 'package:get_it/get_it.dart';

import 'package:prayer_times/core/base/base_presenter.dart';
import 'package:prayer_times/core/di/setup/datasource_setup.dart';
import 'package:prayer_times/core/di/setup/presenter_setup.dart';
import 'package:prayer_times/core/di/setup/repository_setup.dart';
import 'package:prayer_times/core/di/setup/service_setup.dart';
import 'package:prayer_times/core/di/setup/usecase_setup.dart';

final GetIt _serviceLocator = GetIt.instance;

// This code implements a wrapper function around the `get` function from the
// `get_it` package. The purpose of this wrapper is to provide a simplified and
// centralized way of retrieving registered instances of classes.
//
// By using this wrapper instead of directly calling the get function, we avoid
// tight coupling to the specific service locator implementation, which can lead
// to vendor lock-in. This abstraction allows for flexibility in choosing a
// different service locator plugin in the future if needed.
//
// The wrapper function encapsulates the complexity of the service locator and
// provides a cleaner and more readable interface for retrieving dependencies
// throughout the codebase.

/// Provides a way to retrieve an instance of a class registered
/// with the service locator.
T locate<T extends Object>() => _serviceLocator.get<T>();

void dislocate<T extends BasePresenter>() => unloadPresenterManually<T>();

class ServiceLocator {
  ServiceLocator._();

  /// Sets up the whole dependency injection system by calling various setup
  /// methods in a certain order.
  ///
  /// Also provides an optional flag to only start services and skip the other
  /// setup steps.
  ///
  /// Ensures that all necessary dependencies are initialized before starting
  /// the application.
  static Future<void> setUp({bool startOnlyService = false}) async {
    // final ServiceLocator locator = ServiceLocator._();

    final ServiceSetup setUpService = ServiceSetup(_serviceLocator);
    await setUpService.setup();
    if (startOnlyService) return;
    final DatasourceSetup setUpDataSources = DatasourceSetup(_serviceLocator);
    await setUpDataSources.setup();
    final RepositorySetup setUpRepositories = RepositorySetup(_serviceLocator);
    await setUpRepositories.setup();
    final UsecaseSetup setUpUseCase = UsecaseSetup(_serviceLocator);
    await setUpUseCase.setup();
    final PresenterSetup setUpPresenters = PresenterSetup(_serviceLocator);
    await setUpPresenters.setup();
  }
}
