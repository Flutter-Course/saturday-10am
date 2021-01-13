class Product {
  String _title, _description, _forWho, _category, _id, _date, _vendorId;
  double _price;
  bool _available;
  List<String> _photosUrls;

  bool get available => _available;

  String get title => _title;

  get description => _description;

  double get price => _price;

  get vendorId => _vendorId;

  get date => _date;

  get id => _id;

  get category => _category;

  get forWho => _forWho;

  List<String> get photosUrls => [..._photosUrls];

  Product(
      this._title,
      this._description,
      this._forWho,
      this._category,
      this._id,
      this._date,
      this._vendorId,
      this._price,
      this._available,
      this._photosUrls);

  Product.fromDocument(document)
      : this._title = document.data()['title'],
        this._description = document.data()['description'],
        this._forWho = document.data()['forWho'],
        this._category = document.data()['category'],
        this._id = document.id,
        this._date = document.data()['date'],
        this._vendorId = document.data()['vendorID'],
        this._price = document.data()['price'].toDouble(),
        this._available = document.data()['available'],
        this._photosUrls = (document.data()['photos'] as List)
            .map((e) => e.toString())
            .toList();
}
