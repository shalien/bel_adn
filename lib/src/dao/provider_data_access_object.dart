import 'dart:convert';

import 'package:meta/meta.dart';

import '../data_access_object.dart';
import '../model/provider.dart';
import '../model/topic.dart';

/// The [DataAccessObject] for the [Provider] class
@immutable
class ProviderDataAccessObject extends DataAccessObject<Provider> {
  static ProviderDataAccessObject? _providerDataAccessObject;

  ProviderDataAccessObject._() : super(resource: "providers");

  /// Factory used to create and a single instance during the program run
  factory ProviderDataAccessObject() {
    return _providerDataAccessObject ??= ProviderDataAccessObject._();
  }
}
