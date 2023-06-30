import 'dart:convert';

import '../dao/provider_link_data_access_object.dart';
import '../model.dart';
import 'provider.dart';

final class ProviderLink extends Model {
  static ProviderLinkDataAccessObject dao = ProviderLinkDataAccessObject();

  final List<int> providers;

  final int providerTypeId;

  final Uri link;

  ProviderLink({
    int? id,
    required this.providers,
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
    List<int> providers = json['providers'] == null
        ? []
        : (json['providers'] as List)
            .map((e) => Provider.fromJson(e).id!)
            .toList();

    return ProviderLink(
      id: json['id'],
      providers: providers,
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
        'providers': providers,
        'link': link.toString(),
        'provider_type_id': providerTypeId,
        ...?id != null ? {'id': id} : null,
        ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
        ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      },
    );
  }
}
