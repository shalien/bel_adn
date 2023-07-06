import 'dart:convert';

import '../dao/provider_link_data_access_object.dart';
import '../model.dart';
import 'provider.dart';
import 'provider_type.dart';

final class ProviderLink extends Model {
  static ProviderLinkDataAccessObject dao = ProviderLinkDataAccessObject();

  final int providerTypeId;

  ProviderType? _providerType;

  Future<ProviderType> get providerType async {
    _providerType ??= await ProviderType.dao.show(providerTypeId);
    return _providerType!;
  }

  List<Provider> _providers = [];

  Future<List<Provider>> get providers async {
    if (_providers.isEmpty) {
      _providers = await ProviderLink.dao.showProviders(this);
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
