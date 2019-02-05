class Genre{

  int _id;
  String _name;

  Genre(result){
    this._id = result['id'];
    this._name = result['name'];
  }

  int get id => _id;
  String get name => _name;
}
