class AddressItemModel {
  final String id;
  final String city;
  final String country;
  final String image;
  final bool isChosen;

  AddressItemModel({
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
}

List<AddressItemModel> dummyLocations = [
  AddressItemModel(id: '1', city: 'Cairo', country: 'Egypt'),
  AddressItemModel(id: '2', city: 'Giza', country: 'Egypt'),
  AddressItemModel(id: '3', city: 'Alexandria', country: 'Egypt'),
];
