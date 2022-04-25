class FinancialTip {
  List<Data>? data;

  FinancialTip({this.data});

  FinancialTip.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? topic;
  String? description;

  Data({this.id, this.topic, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['description'] = this.description;
    return data;
  }
}
