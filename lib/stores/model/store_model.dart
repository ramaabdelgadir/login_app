class StoreModel {

final int id;
final String name;
final double review;
final String location;

StoreModel({
required this.id,
required this.name,
required this.location,
required this.review
});

Map<String,dynamic> toMap(){
  return {};
}

factory StoreModel.fromMap(Map<String,dynamic> data){
  return StoreModel(
    id: int.parse(data['id']),
    name: data['name'],
    location: data['location'],
    review: double.parse(data['review']));

}

}
