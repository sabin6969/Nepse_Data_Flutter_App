import 'dart:convert';

class CompaniesModel {
  CompaniesModel({
    required this.metadata,
    required this.data,
  });
  late final Metadata metadata;
  late final List<Data> data;

  CompaniesModel.fromJson(Map<String, dynamic> json) {
    metadata = Metadata.fromJson(json['metadata']);
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData['metadata'] = metadata.toJson();
    jsonData['data'] = data.map((e) => e.toJson()).toList();
    return jsonData;
  }
}

class Metadata {
  Metadata({
    required this.totalAmt,
    required this.totalQty,
    required this.totalTrans,
  });
  late final num totalAmt;
  late final num totalQty;
  late final num totalTrans;

  Metadata.fromJson(Map<String, dynamic> json) {
    totalAmt = json['totalAmt'];
    totalQty = json['totalQty'];
    totalTrans = json['totalTrans'];
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData['totalAmt'] = totalAmt;
    jsonData['totalQty'] = totalQty;
    jsonData['totalTrans'] = totalTrans;
    return jsonData;
  }
}

class Data {
  Data({
    required this.company,
    required this.price,
    required this.numTrans,
    required this.tradedShares,
    required this.amount,
  });
  late final Company company;
  late final Price price;
  late final num numTrans;
  late final num tradedShares;
  late final num? amount;

  Data.fromJson(Map<String, dynamic> json) {
    company = Company.fromJson(json['company']);
    price = Price.fromJson(json['price']);
    numTrans = json['numTrans'];
    tradedShares = json['tradedShares'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData['company'] = company.toJson();
    jsonData['price'] = price.toJson();
    jsonData['numTrans'] = numTrans;
    jsonData['tradedShares'] = tradedShares;
    jsonData['amount'] = amount;
    return jsonData;
  }
}

class Company {
  Company({
    required this.code,
    required this.name,
  });
  late final String code;
  late final String name;

  Company.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData['code'] = code;
    jsonData['name'] = name;
    return jsonData;
  }
}

class Price {
  Price({
    required this.open,
    required this.max,
    required this.min,
    required this.close,
    required this.prevClose,
    required this.diff,
  });
  late final num? open;
  late final num? max;
  late final num? min;
  late final num? close;
  late final num? prevClose;
  late final num? diff;

  Price.fromJson(Map<String, dynamic> json) {
    open = json['open'];
    max = json['max'];
    min = json['min'];
    close = json['close'];
    prevClose = json['prevClose'];
    diff = json['diff'];
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData['open'] = open;
    jsonData['max'] = max;
    jsonData['min'] = min;
    jsonData['close'] = close;
    jsonData['prevClose'] = prevClose;
    jsonData['diff'] = diff;
    return jsonData;
  }
}
