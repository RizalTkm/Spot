import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:spot/core/constants.dart';

import 'package:spot/core/congestionSlider.dart';
import 'package:spot/core/worthvisitslider.dart';
import 'package:spot/domain/Firestore_functions/firebaseHelperFuntions.dart';

import 'package:spot/presentation/addSpotScreen/widget/current_location_access.dart';
import 'package:spot/presentation/addSpotScreen/widget/smallAppbar_widget.dart';
import 'package:spot/presentation/addSpotScreen/widget/spot_type_card.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard%20TextFieldMini.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard_font.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard_textfield.dart';

import 'package:spot/presentation/mapScreen/map_screen.dart';

class AddSpotscreen extends StatefulWidget {
  const AddSpotscreen({
    super.key,
  });

  @override
  State<AddSpotscreen> createState() => _AddSpotscreenState();
}

class _AddSpotscreenState extends State<AddSpotscreen> {
  Position? _position;
  bool isloading = false;
  String adressFromCoordinates = '';

  File? image;
  final List<File> _imagelist = [];

  Future<void> addmultiimage(ImageSource source) async {
    final selectedimage = await ImagePicker().pickMultiImage(imageQuality: 60);

    final selectedimagelist =
        selectedimage.map<File>((XFile) => File(XFile.path)).toList();

    selectedimagelist.isNotEmpty
        ? _imagelist.addAll(selectedimagelist)
        : print('selected image is empty');

    setState(() {});
  }

  Future<void> addDetails(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 60);
      if (image == null)
        return null;
      else {
        final tempimage = File(image.path);
        final List<File> tempimagelist = [];
        tempimagelist.map<File>((File) => tempimage);

        setState(() {
          this.image = tempimage;
        });
      }
    } on PlatformException catch (e) {
      print('failed to pick image : $e');
    }
  }

  final spotnameTextcontroller = TextEditingController();

  final descriptionTextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusNode currentfocus = FocusScope.of(context);
          if (!currentfocus.hasPrimaryFocus) {
            currentfocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: SmallAppbarWidget(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenwidth * .02),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StandardFont(
                      title: 'Spot Name',
                    ),
                    StandardTextField(
                      textcontroller: spotnameTextcontroller,
                      hintfont: 'Type your Spot name',
                    ),
                    const StandardFont(title: 'Spot Type'),
                    Column(
                      children: const [
                        LimitedBox(
                          maxHeight: 70,
                          child: HorizontalSPotList(),
                        ),
                      ],
                    ),
                    const StandardFont(title: 'If others'),
                    StandardTextField(
                      hintfont: 'Anything treated as SPot ',
                      textcontroller: TextEditingController(),
                    ),
                    const StandardFont(title: 'Add details'),
                    kheight10,
                    Center(
                      child: image != null
                          ? LimitedBox(
                              maxHeight: 250,
                              maxWidth: 250,
                              child: Stack(children: [
                                Container(
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Image.file(File(image!.path))),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.black,
                                    child: IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            image = null;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.close_sharp,
                                          size: 15,
                                        )),
                                  ),
                                )
                              ]),
                            )
                          : _imagelist.length != 0
                              ? Column(
                                  children: [
                                    LimitedBox(
                                      maxHeight: 250,
                                      maxWidth: 250,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            Stack(children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                            ),
                                            child: Image.file(
                                              File(_imagelist[index].path),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.black,
                                              radius: 15,
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _imagelist
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    size: 15,
                                                  )),
                                            ),
                                          )
                                        ]),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          width: 5,
                                        ),
                                        itemCount: _imagelist.length,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                            ' Tap to upload multiple images'),
                                        IconButton(
                                            onPressed: () {
                                              addmultiimage(
                                                  ImageSource.gallery);
                                            },
                                            icon: const Icon(
                                              Icons.photo,
                                              size: 35,
                                            ))
                                      ],
                                    )
                                  ],
                                )
                              : Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Colors.grey.withOpacity(.7),
                                  shadowColor: Colors.green,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(screenwidth * .05),
                                    width: 100,
                                    height: 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  addDetails(
                                                      ImageSource.camera);
                                                },
                                                icon: const Icon(
                                                  Icons.video_camera_back,
                                                  size: 35,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  addmultiimage(
                                                      ImageSource.gallery);
                                                },
                                                icon: const Icon(
                                                  Icons.photo,
                                                  size: 35,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                    ),
                    kheight,
                    const StandardFont(title: 'Description'),
                    TextfieldMini(
                        maxlines: 10,
                        hintfont: 'Type descripiton',
                        textcontroller: descriptionTextcontroller),
                    const StandardFont(title: 'Worth Visit'),
                    WorthvisitSlider(),
                    StandardFont(title: 'Level of congestion'),
                    CongestionSliderWidget(),
                    const StandardFont(title: 'Add Location'),
                    // StandardTextField(
                    //   hintfont: 'Type location',
                    //   textcontroller: locationTextcontroller,
                    // ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: _position == null
                                  ? Colors.grey.withOpacity(.4)
                                  : Colors.grey.withOpacity(.9),
                              borderRadius: BorderRadius.circular(5)),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          height: 50,
                          width: 250,
                          child: _position != null
                              ? ListView(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(adressFromCoordinates),
                                  )
                                ])
                              : const Center(
                                  child: Text('Current location is unknown')),
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  final positionValue = await GetCurrentLocation
                                      .determinePosition();
                                  final latitudeValue = positionValue.latitude;
                                  final longitudeValue =
                                      positionValue.longitude;

                                  final addressValue =
                                      await placemarkFromCoordinates(
                                          latitudeValue, longitudeValue,
                                          localeIdentifier: 'en');
                                  final Placemark placemark = addressValue[0];
                                  String? country = placemark.country;
                                  String? street = placemark.street;
                                  String? locality = placemark.locality;
                                  String? district =
                                      placemark.subAdministrativeArea;
                                  String? state = placemark.administrativeArea;

                                  setState(() {
                                    _position = positionValue;
                                    adressFromCoordinates =
                                        '$locality,$street,$state,$country';
                                  });
                                  print(positionValue.toString());
                                  print(addressValue.toString());
                                },
                                icon: const Icon(Icons.gps_fixed_outlined)),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MapScreen()));
                                },
                                icon: const Icon(Icons.map_rounded))
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (spotnameTextcontroller.text.isEmpty ||
                                descriptionTextcontroller.text.isEmpty ||
                                adressFromCoordinates.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text(' One of the field is Empty')));
                            } else if (spotnameTextcontroller
                                    .text.characters.first
                                    .contains(' ') ||
                                descriptionTextcontroller.text.characters.first
                                    .contains(' ')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('  Avoid initial spaces')));
                            } else if (_imagelist.isNotEmpty || image != null) {
                              setState(() {
                                isloading = true;
                              });

                              // Future.delayed(Duration(seconds: 15), () {
                              //   setState(() {
                              //     isloading = false;
                              //   });
                              // });

                              if (_imagelist.isNotEmpty) {
                                await FirestoreHelperFunctions()
                                    .addingSpotTofirebase(
                                        spotnameTextcontroller,
                                        adressFromCoordinates,
                                        descriptionTextcontroller,
                                        _imagelist);

                                _imagelist.clear();

                                await ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text(' The spot is added')));
                              }

                              if (image != null) {
                                await FirestoreHelperFunctions()
                                    .addingSpotToFirebaseWithSingleimage(
                                        spotnameTextcontroller,
                                        adressFromCoordinates,
                                        descriptionTextcontroller,
                                        image);
                                setState(() {
                                  image = null;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(' The spot is added')));
                              }

                              setState(() {
                                isloading = false;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please add any image')));
                            }
                          },
                          child: isloading
                              ? SizedBox(
                                  height: 40,
                                  width: 300,
                                  child: Lottie.network(
                                      'https://assets8.lottiefiles.com/packages/lf20_uay09kf4.json'),
                                )
                              : const Text(
                                  'Add Spot',
                                  style: TextStyle(fontSize: 15),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HorizontalSPotList extends StatelessWidget {
  const HorizontalSPotList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: const [
        SpotTypeCard(spotType: 'Music Concert'),
        SpotTypeCard(spotType: 'Accident'),
        SpotTypeCard(spotType: 'Festival'),
        SpotTypeCard(spotType: 'trafficblock')
      ],
    );
  }
}
