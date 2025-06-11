import 'package:equatable/equatable.dart';

import 'value.dart';

class Data extends Equatable {
  final String? odata;
  final String? odatas;
  final List<Value>? value;

  const Data({this.odata, this.odatas, this.value});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    odata: json['odata.metadata'] as String?,
    odatas: json['odata.sql'] as String?,
    value:
        (json['value'] as List<dynamic>?)
            ?.map((e) => Value.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'odata': odata,
    'odatas': odata,
    'value': value?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [odata, odata, value];
}
