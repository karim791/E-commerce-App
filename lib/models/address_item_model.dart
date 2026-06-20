
class AddressItemModel {
  final String id;
  final String city;
  final String country;
  final String image;
  final bool isChosen;

  const AddressItemModel({
    required this.id,
    required this.city,
    required this.country,
    this.image =
        'https://previews.123rf.com/images/emojoez/emojoez1903/emojoez190300018/119684277-illustrations-design-concept-location-maps-with-road-follow-route-for-destination-drive-by-gps.jpg',
    this.isChosen = false,
  });

  AddressItemModel copyWith({
    String? id,
    String? city,
    String? country,
    String? image,
    bool? isChosen,
  }) {
    return AddressItemModel(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      isChosen: isChosen ?? this.isChosen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'city': city,
      'country': country,
      'image': image,
      'isChosen': isChosen,
    };
  }

  factory AddressItemModel.fromMap(Map<String, dynamic> map) {
    return AddressItemModel(
      id: map['id'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
      image: map['image'] as String,
      isChosen: map['isChosen'] as bool,
    );
  }

}

