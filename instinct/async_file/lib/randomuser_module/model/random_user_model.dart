// class RandomUserModel {
//   Info info;
//   RandomUserModel({  this.info});
//   factory RandomUserModel.fromMap(Map<String, dynamic> map) {
//     return RandomUserModel(info: Info.fromMap(map['info']));
//   }
// }

// class Info {
//   final String seed;
//   final int results;
//   final int page;
//   final String version;

//   Info(
//       {this.seed = "no seed",
//       this.results = 0,
//       this.page = 0,
//       this.version = "no version"});

//   //create name constractor
//   factory Info.fromMap(Map<String, dynamic> map) {
//     return Info(
//         page: map["page"],
//         results: map["results"],
//         seed: map["seed"],
//         version: map["version"]);
//   }
// }

// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);


class RandomUserModel {
  RandomUserModel({

    this.results= const[],
    required
    this.info,
  });

  List<Result> results;
  Info info;

  factory RandomUserModel.fromMap(Map<String, dynamic> json) => RandomUserModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
        info: Info.fromMap(json["info"]),
      );

  Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "info": info.toMap(),
      };
}

class Info {
  Info({
    this.seed='no seed',
    this.results=0,
    this.page=0,
    this.version='no seed',
  });

  String seed;
  int results;
  int page;
  String version;

  factory Info.fromMap(Map<String, dynamic> json) => Info(
        seed: json["seed"]??'no seed',
        results: json["results"]??0,
        page: json["page"]??0,
        version: json["version"]??'no version',
      );

  Map<String, dynamic> toMap() => {
        "seed": seed,
        "results": results,
        "page": page,
        "version": version,
      };
}

class Result {
  Result({
    this.gender = "no gender",
    required this.name,
    required this.location,
    this.email = "no email",
    required this.login,
    required this.dob,
    required this.registered,
    this.phone = "no phone",
    this.cell = "no cell",
    required this.id,
    required this.picture,
    this.nat = "no nat",
  });

  String gender;
  Name name;
  Location location;
  String email;
  Login login;
  Dob dob;
  Dob registered;
  String phone;
  String cell;
  Id id;
  Picture picture;
  String nat;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        gender: json["gender"] ?? "no gender",
        name: Name.fromMap(json["name"] ?? {}),
        location: Location.fromMap(json["location"] ?? {}),
        email: json["email"] ?? "no email",
        login: Login.fromMap(json["login"] ?? {}),
        dob: Dob.fromMap(json["dob"] ?? {}),
        registered: Dob.fromMap(json["registered"] ?? {}),
        phone: json["phone"] ?? "no phone",
        cell: json["cell"] ?? "no cell",
        id: Id.fromMap(json["id"] ?? {}),
        picture: Picture.fromMap(json["picture"] ?? {}),
        nat: json["nat"] ?? "no nat",
      );

  Map<String, dynamic> toMap() => {
        "gender": gender,
        "name": name.toMap(),
        "location": location.toMap(),
        "email": email,
        "login": login.toMap(),
        "dob": dob.toMap(),
        "registered": registered.toMap(),
        "phone": phone,
        "cell": cell,
        "id": id.toMap(),
        "picture": picture.toMap(),
        "nat": nat,
      };
}

class Dob {
  Dob({
    this.date = 'no date',
    this.age = 0,
  });

  String date;
  int age;

  factory Dob.fromMap(Map<String, dynamic> json) => Dob(
        date: json["date"] ?? "no date",
        age: json["age"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "date": date,
        "age": age,
      };
}

class Id {
  Id({
    this.name = 'no name',
    this.value = 'no value',
  });

  String name;
  String value;

  factory Id.fromMap(Map<String, dynamic> json) => Id(
        name: json["name"] ?? 'no name',
        value: json["value"] ?? 'no value',
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "value": value == null ? null : value,
      };
}

class Location {
  Location({
    required this.street,
    this.city = 'no city',
    this.state = 'no state',
    this.country = 'no country',
    this.postcode = 'no country',
    required this.coordinates,
    required this.timezone,
  });

  Street street;
  String city;
  String state;
  String country;
  dynamic postcode;
  Coordinates coordinates;
  Timezone timezone;

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        street: Street.fromMap(json["street"] ?? {}),
        city: json["city"] ?? 'no city',
        state: json["state"] ?? 'no state',
        country: json["country"] ?? 'no country',
        postcode: json["postcode"] ?? 'no country',
        coordinates: Coordinates.fromMap(json["coordinates"] ?? {}),
        timezone: Timezone.fromMap(json["timezone"] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        "street": street.toMap(),
        "city": city,
        "state": state,
        "country": country,
        "postcode": postcode,
        "coordinates": coordinates.toMap(),
        "timezone": timezone.toMap(),
      };
}

class Coordinates {
  Coordinates({
    this.latitude = 'no latitude',
    this.longitude = 'no longitude',
  });

  String latitude;
  String longitude;

  factory Coordinates.fromMap(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"] ?? 'no latitude',
        longitude: json["longitude"] ?? 'no longitude',
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Street {
  Street({
    this.number = 0,
    this.name = 'no name',
  });

  int number;
  String name;

  factory Street.fromMap(Map<String, dynamic> json) => Street(
        number: json["number"] ?? 0,
        name: json["name"] ?? 'no name',
      );

  Map<String, dynamic> toMap() => {
        "number": number,
        "name": name,
      };
}

class Timezone {
  Timezone({
    this.offset = 'no offset',
    this.description = 'no description',
  });

  String offset;
  String description;

  factory Timezone.fromMap(Map<String, dynamic> json) => Timezone(
        offset: json["offset"] ?? 'no offset',
        description: json["description"] ?? 'no description',
      );

  Map<String, dynamic> toMap() => {
        "offset": offset,
        "description": description,
      };
}

class Login {
  Login({
    this.uuid = 'no uuid',
    this.username = 'no username',
    this.password = 'no password',
    this.salt = 'no salt',
    this.md5 = 'no md5',
    this.sha1 = 'no sha1',
    this.sha256 = 'no sha256',
  });

  String uuid;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        uuid: json["uuid"] ?? 'no uuid',
        username: json["username"] ?? 'no username',
        password: json["password"] ?? 'no password',
        salt: json["salt"] ?? 'no salt',
        md5: json["md5"] ?? 'no md5',
        sha1: json["sha1"] ?? 'no sha1',
        sha256: json["sha256"] ?? 'no sha256',
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "username": username,
        "password": password,
        "salt": salt,
        "md5": md5,
        "sha1": sha1,
        "sha256": sha256,
      };
}

class Name {
  Name({
    this.title = "no title",
    this.first = "no first",
    this.last = "no last",
  });

  String title;
  String first;
  String last;

  factory Name.fromMap(Map<String, dynamic> json) => Name(
        title: json["title"] ?? "no title",
        first: json["first"] ?? "no first",
        last: json["last"] ?? "no last",
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "first": first,
        "last": last,
      };
}

class Picture {
  Picture({
    this.large = "No large",
    this.medium = "No medium",
    this.thumbnail = "No thumbnail",
  });

  String large;
  String medium;
  String thumbnail;

  factory Picture.fromMap(Map<String, dynamic> json) => Picture(
        large: json["large"] ?? "No Large",
        medium: json["medium"] ?? "No medium",
        thumbnail: json["thumbnail"] ?? "No thumbnail",
      );

  Map<String, dynamic> toMap() => {
        "large": large,
        "medium": medium,
        "thumbnail": thumbnail,
      };
}
