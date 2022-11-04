import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/presentation/addSpotScreen/widget/smallAppbar_widget.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard_font.dart';
import 'package:spot/presentation/updateScreen/customAppbar.dart';
import 'package:spot/presentation/updateScreen/widget/editableText.dart';

class Editscreen extends StatelessWidget {
  Editscreen(
      {super.key,
      required this.spotname,
      required this.spotlocation,
      required this.spotdescription,
      required this.imageurls});

  String spotname;
  String spotlocation;
  String spotdescription;
  List<dynamic> imageurls;

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            child: CustomAppbarwidget(
                spotname: spotname,
                spotlocation: spotlocation,
                spotdescription: spotdescription,
                imageurls: imageurls),
            preferredSize: Size.fromHeight(70)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kheight10,
                CarouselSlider.builder(
                  itemCount: imageurls.length,
                  options: CarouselOptions(
                      height: 400,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false),
                  itemBuilder: (context, index, realIndex) {
                    final anyimageurl = imageurls[index];
                    return imagebuilder(anyimageurl, index);
                  },
                ),
                kheight,
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(onPressed: () {}, child: Text('Update'))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: EditableTextWidget(spotText: spotname)
                    //  StandardFont(title: spotname),
                    ),
                kheight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on),
                    StandardFont(title: spotlocation),
                  ],
                ),
                kheight,
                LimitedBox(
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                  child: Text(
                    spotdescription,
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget imagebuilder(String urlimage, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(urlimage),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  currentprogresscolor(double progress) {
    if (progress <= 50) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
