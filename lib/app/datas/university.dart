class University {
  int id;
  String fullName;
  String name;
  String ibge;
  String city;
  String uf;
  String zipcode;
  String street;
  String number;
  String neighborhood;
  String phone;

  University(
      {
        this.id = 0,
        this.fullName = "",
        this.name = "",
        this.ibge= "",
        this.city= "",
        this.uf= "",
        this.zipcode= "",
        this.street= "",
        this.number= "",
        this.neighborhood= "",
        this.phone= "",
        });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
        id : json['id'],
        fullName : json['full_name'],
        name  :  json['name'],
        ibge  :  json['ibge'],
        city  :  json['city'],
        uf  :  json['uf'],
        zipcode  :  json['zipcode'],
        street  :  json['street'],
        number  :  json['number'],
        neighborhood  :  json['neighborhood'],
        phone  :  json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['name'] = this.name;
    data['ibge'] = this.ibge;
    data['city'] = this.city;
    data['uf'] = this.uf;
    data['zipcode'] = this.zipcode;
    data['street'] = this.street;
    data['number'] = this.number;
    data['neighborhood'] = this.neighborhood;
    data['phone'] = this.phone;
    return data;
  }
}
