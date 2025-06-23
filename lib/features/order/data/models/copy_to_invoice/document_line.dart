import 'package:equatable/equatable.dart';

class DocumentLine extends Equatable {
  final String? itemCode;
  final int? baseLine;
  final int? baseEntry;
  final int? baseType;

  const DocumentLine({
    this.itemCode,
    this.baseLine,
    this.baseEntry,
    this.baseType,
  });

  factory DocumentLine.fromJson(Map<String, dynamic> json) => DocumentLine(
    itemCode: json['ItemCode'] as String?,
    baseLine: json['BaseLine'] as int?,
    baseEntry: json['BaseEntry'] as int?,
    baseType: json['BaseType'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'ItemCode': itemCode,
    'BaseLine': baseLine,
    'BaseEntry': baseEntry,
    'BaseType': baseType,
  };

  @override
  List<Object?> get props => [itemCode, baseLine, baseEntry, baseType];
}
