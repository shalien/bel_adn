import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Destination media', () async {
    Destination destination = await DestinationDataAccessObject().show(126472);

    print((await destination.medias).length);

    expect(await destination.medias, isA<Set<Media>>());
  });
}
