class UserModel {
  int? id;
  String? nom;
  String? prenom;
  String? imguser;

  UserModel({this.id, this.nom, this.prenom, this.imguser});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
    imguser = json['img_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['img_user'] = this.imguser;
    return data;
  }
}
