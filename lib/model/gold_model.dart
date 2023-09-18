class GoldModel {
  int? prodcodeId;
  String? prodcode;
  String? designcode;
  String? description;
  String? itemName;
  String? imageData;
  double? gwt;
  String? gwtUnit;
  double? diawt;
  String? diawtUnit;
  double? stWt;
  String? stWtUnit;
  double? netWt;
  String? purity;
  double? totalAmt;
  String? imageSource;

  GoldModel(
      {this.prodcodeId,
      this.prodcode,
      this.designcode,
      this.description,
      this.itemName,
      this.imageData,
      this.gwt,
      this.gwtUnit,
      this.diawt,
      this.diawtUnit,
      this.stWt,
      this.stWtUnit,
      this.netWt,
      this.purity,
      this.totalAmt,
      this.imageSource});

  GoldModel.fromJson(Map<String, dynamic> json) {
    prodcodeId = json['prodcodeId'];
    prodcode = json['prodcode'];
    designcode = json['designcode'];
    description = json['description'];
    itemName = json['itemName'];
    imageData = json['imageData'];
    gwt = json['gwt'];
    gwtUnit = json['gwtUnit'];
    diawt = json['diawt'];
    diawtUnit = json['diawtUnit'];
    stWt = json['stWt'];
    stWtUnit = json['stWtUnit'];
    netWt = json['netWt'];
    purity = json['purity'];
    totalAmt = json['totalAmt'];
    imageSource = json['imageSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prodcodeId'] = this.prodcodeId;
    data['prodcode'] = this.prodcode;
    data['designcode'] = this.designcode;
    data['description'] = this.description;
    data['itemName'] = this.itemName;
    data['imageData'] = this.imageData;
    data['gwt'] = this.gwt;
    data['gwtUnit'] = this.gwtUnit;
    data['diawt'] = this.diawt;
    data['diawtUnit'] = this.diawtUnit;
    data['stWt'] = this.stWt;
    data['stWtUnit'] = this.stWtUnit;
    data['netWt'] = this.netWt;
    data['purity'] = this.purity;
    data['totalAmt'] = this.totalAmt;
    data['imageSource'] = this.imageSource;
    return data;
  }
}
