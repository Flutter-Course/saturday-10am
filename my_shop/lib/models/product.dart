import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String _id, _title, _description, _category, _gender, _age, _date, _vendorId;
  double _price;
  bool _available;
  List<String> _photos;

  String get id => this._id;
  set id(String id) {
    this._id = id;
  }

  bool get available => this._available;
  set available(bool available) {
    this._available = available;
  }

  String get vendorId => this._vendorId;
  set vendorId(String vendorId) {
    this._vendorId = vendorId;
  }

  String get date => this._date;
  set date(String date) {
    this._date = date;
  }

  String get title => this._title;
  set title(String title) {
    this._title = title;
  }

  String get description => this._description;
  set description(String description) {
    this._description = description;
  }

  String get category => this._category;
  set category(String category) {
    this._category = category;
  }

  String get gender => this._gender;
  set gender(String gender) {
    this._gender = gender;
  }

  String get age => this._age;
  set age(String age) {
    this._age = age;
  }

  double get price => this._price;
  set price(double price) {
    this._price = price;
  }

  List<String> get photos => this._photos;
  set photos(List<String> photos) {
    this._photos = photos;
  }

  Product.fromDocument(QueryDocumentSnapshot document)
      : this._id = document.id,
        this._age = document.data()['age'],
        this._available = document.data()['available'],
        this._category = document.data()['category'],
        this._date = document.data()['date'],
        this._description = document.data()['description'],
        this._gender = document.data()['gender'],
        this._photos = document.data()['photos'],
        this._price = document.data()['price'],
        this._title = document.data()['title'],
        this._vendorId = document.data()['vendorId'];
}
