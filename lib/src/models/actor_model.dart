class Actors {

  List<Actor> actorsList = new List();

  Actors.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final actor = new Actor.fromJsonMap(item);
      actorsList.add(actor);
    }
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  String getPhoto() {
    if (profilePath == null) {
      return 'https://drogaspoliticacultura.net/wp-content/uploads/2017/09/placeholder-user.jpg'; 
    }
    else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}