import 'package:equatable/equatable.dart';
import 'package:revival/features/order/data/models/single_order/single_order.dart';

import 'document_line.dart';

class CopyToInvoice extends Equatable {
  final String? cardCode;
  final List<DocumentLine>? documentLines;

  const CopyToInvoice({this.cardCode, this.documentLines});

  factory CopyToInvoice.fromJson(Map<String, dynamic> json) => CopyToInvoice(
    cardCode: json['CardCode'] as String?,
    documentLines:
        (json['DocumentLines'] as List<dynamic>?)
            ?.map((e) => DocumentLine.fromJson(e as Map<String, dynamic>))
            .toList(),
  );
  factory CopyToInvoice.fromSingleOrder(SingleOrder singleOrder) {
    return CopyToInvoice(
      cardCode: singleOrder.data?.cardCode,
      documentLines:
          singleOrder.data?.orderLines
              ?.map(
                (orderLine) => DocumentLine(
                  itemCode: orderLine.itemCode,
                  baseLine:
                      orderLine.lineNum, // Assuming lineNum maps to baseLine
                  baseEntry:
                      orderLine.docEntry, // Assuming docEntry maps to baseEntry
                  baseType: 17,
                ),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'CardCode': cardCode,
    'DocumentLines': documentLines?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [cardCode, documentLines];
}
