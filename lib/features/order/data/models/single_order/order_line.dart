import 'package:equatable/equatable.dart';

class OrderLine extends Equatable {
	final int? docEntry;
	final int? lineNum;
	final String? itemCode;
	final String? itemName;
	final String? itemGroupName;
	final double? quantity;
	final double? price;
	final double? discPrcnt;
	final double? lineTotal;
	final String? whsCode;
	final String? uomCode;
	final double? openQty;
	final dynamic baseLine;
	final dynamic baseEntry;
	final int? baseType;

	const OrderLine({
		this.docEntry, 
		this.lineNum, 
		this.itemCode, 
		this.itemName, 
		this.itemGroupName, 
		this.quantity, 
		this.price, 
		this.discPrcnt, 
		this.lineTotal, 
		this.whsCode, 
		this.uomCode, 
		this.openQty, 
		this.baseLine, 
		this.baseEntry, 
		this.baseType, 
	});

	factory OrderLine.fromJson(Map<String, dynamic> json) => OrderLine(
				docEntry: json['docEntry'] as int?,
				lineNum: json['lineNum'] as int?,
				itemCode: json['itemCode'] as String?,
				itemName: json['itemName'] as String?,
				itemGroupName: json['itemGroupName'] as String?,
				quantity: (json['quantity'] as num?)?.toDouble(),
				price: json['price'] as double?,
				discPrcnt: json['discPrcnt'] as double?,
				lineTotal: (json['lineTotal'] as num?)?.toDouble(),
				whsCode: json['whsCode'] as String?,
				uomCode: json['uomCode'] as String?,
				openQty: (json['openQty'] as num?)?.toDouble(),
				baseLine: json['baseLine'] as dynamic,
				baseEntry: json['baseEntry'] as dynamic,
				baseType: json['baseType'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'docEntry': docEntry,
				'lineNum': lineNum,
				'itemCode': itemCode,
				'itemName': itemName,
				'itemGroupName': itemGroupName,
				'quantity': quantity,
				'price': price,
				'discPrcnt': discPrcnt,
				'lineTotal': lineTotal,
				'whsCode': whsCode,
				'uomCode': uomCode,
				'openQty': openQty,
				'baseLine': baseLine,
				'baseEntry': baseEntry,
				'baseType': baseType,
			};

	@override
	List<Object?> get props {
		return [
				docEntry,
				lineNum,
				itemCode,
				itemName,
				itemGroupName,
				quantity,
				price,
				discPrcnt,
				lineTotal,
				whsCode,
				uomCode,
				openQty,
				baseLine,
				baseEntry,
				baseType,
		];
	}
}
