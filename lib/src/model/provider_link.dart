import 'dart:convert';

import 'package:bel_adn/bel_adn.dart';


class ProviderLink extends Model {
  final int providerTypeId;

  ProviderType? _providerType;

  Future<ProviderType> get providerType async {
    _providerType ??= await ProviderTypeDataAccessObject().show(providerTypeId);
    return _providerType!;
  }

  List<Provider> _providers = [];

  Future<List<Provider>> get providers async {
    if (_providers.isEmpty) {
      _providers = await ProviderLinkDataAccessObject().showProviders(this);
    }
    return _providers;
  }

  final Uri link;

  ProviderLink({
    int? id,
    required this.link,
    required this.providerTypeId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory ProviderLink.fromJson(Map json) {
    return ProviderLink(
      id: json['id'],
      link: Uri.parse(json['link']),
      providerTypeId: json['provider_type_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  @override
  String toJson() {
    return jsonEncode(
      {
        'link': link.toString(),
        'provider_type_id': providerTypeId,
        ...?id != null ? {'id': id} : null,
        ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
        ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      },
    );
  }
}
