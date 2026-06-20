import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/view_models/address_cubit/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    final locationController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Address Page'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose your location',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  'Let\'s find an unforgettable event. Choose a location below to get started : ',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.grey),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                    ),
                    hintText: 'Write location: city-country',
                    suffixIcon: BlocConsumer<AddressCubit, AddressState>(
                      bloc: addressCubit,
                      listenWhen: (previous, current) =>
                          current is AddedLocation ||
                          current is ConfirmLocationLoaded,
                      listener: (context, state) {
                        if (state is AddedLocation) {
                          locationController.clear();
                        }
                        if (state is ConfirmLocationLoaded) {
                          Navigator.of(context).pop();
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is AddingLocation ||
                          current is AddedLocation ||
                          current is AddingLocationFailure,
                      builder: (context, state) {
                        if (state is AddingLocation) {
                          return Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.grey,
                            ),
                          );
                        }
                        return IconButton(
                          onPressed: () async {
                            if (locationController.text.isNotEmpty) {
                              await addressCubit.addingLocation(
                                locationController.text,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Enter Valid Location')),
                              );
                            }
                          },
                          icon: Icon(Icons.add, color: Colors.grey),
                        );
                      },
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  'Select Location',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                BlocBuilder<AddressCubit, AddressState>(
                  bloc: addressCubit,
                  buildWhen: (previous, current) =>
                      current is FetchingLocation ||
                      current is FetchedLocation ||
                      current is FetchingLocationFailure,
                  builder: (context, state) {
                    if (state is FetchingLocation) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is FetchedLocation) {
                      final locations = state.locations;
                      return locations.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Location List is Empty'),
                              ),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: locations.length,
                              itemBuilder: (context, index) {
                                final location = locations[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: BlocBuilder<AddressCubit, AddressState>(
                                    bloc: addressCubit,
                                    buildWhen: (previous, current) =>
                                        current is ChosenLocation,
                                    builder: (context, state) {
                                      if (state is ChosenLocation) {
                                        final chosenlocation = state.location;
                                        return InkWell(
                                          onTap: () {
                                            addressCubit.changingLocation(
                                              location.id,
                                            );
                                          },
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    chosenlocation!.id ==
                                                        location.id
                                                    ? Theme.of(
                                                        context,
                                                      ).primaryColor
                                                    : Colors.grey.shade300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        location.city,
                                                        style: Theme.of(
                                                          context,
                                                        ).textTheme.titleMedium,
                                                      ),
                                                      Text(
                                                        '${location.city},${location.country}',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 55,
                                                        backgroundColor:
                                                            chosenlocation.id ==
                                                                location.id
                                                            ? Theme.of(
                                                                context,
                                                              ).primaryColor
                                                            : Colors.grey,
                                                      ),
                                                      CircleAvatar(
                                                        radius: 50,
                                                        foregroundImage:
                                                            CachedNetworkImageProvider(
                                                              location.image,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return InkWell(
                                        onTap: () {
                                          addressCubit.changingLocation(
                                            location.id,
                                          );
                                        },
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      location.city,
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.titleMedium,
                                                    ),
                                                    Text(
                                                      '${location.city},${location.country}',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 55,
                                                      backgroundColor:
                                                          Colors.grey,
                                                    ),
                                                    CircleAvatar(
                                                      radius: 50,
                                                      foregroundImage:
                                                          CachedNetworkImageProvider(
                                                            location.image,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                    } else if (state is FetchingLocationFailure) {
                      return Center(child: Text(state.errorMessage));
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),

                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: BlocBuilder<AddressCubit, AddressState>(
                    bloc: addressCubit,
                    buildWhen: (previous, current) =>
                        current is ConfirmLocationLoading ||
                        current is ConfirmLocationLoaded ||
                        current is ConfirmLocationFailure,
                    builder: (context, state) {
                      if (state is ConfirmLocationLoading) {
                        return ElevatedButton(
                          onPressed: null,
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: ()  {
                           addressCubit.confirmLocation();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          'Confirm Address',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
