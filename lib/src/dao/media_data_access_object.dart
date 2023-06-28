import 'package:meta/meta.dart';

import '../data_access_object.dart';
import '../model/media.dart';

/// The [DataAccessObject] for the [Media] class
@immutable
class MediaDataAccessObject extends DataAccessObject<Media> {
  /// The singleton instance for the factory
  static MediaDataAccessObject? _mediaDataAccessObject;

  /// Private constructor
  MediaDataAccessObject._() : super(resource: "medias");

  /// Factory used to create and a single instance during the program run
  factory MediaDataAccessObject() {
    return _mediaDataAccessObject ??= MediaDataAccessObject._();
  }
}
