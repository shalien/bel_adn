import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  late MagnifiqueCoupleClient client;

  Search? createdSearch;
  Search? updatedSearch;

  Topic? testTopic;
  Path? testPath;
  Supplier? testSupplier;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      host: 'http://localhost:8000',
      accessToken: await File('.env').readAsString(),
    );
  });

  group('Search - CRUD', () {});

  tearDownAll(() async {});
}
