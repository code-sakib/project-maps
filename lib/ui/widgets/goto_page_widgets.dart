import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';
import 'package:mapbox_turn_by_turn/data/maps/mapbox_search.dart';
import 'package:mapbox_turn_by_turn/ui/pages/go_to_page.dart';

class LocationTextField extends StatefulWidget {
  final bool displayCurrentLocation;
  LocationTextField({
    Key? key,
    this.displayCurrentLocation = false,
  }) : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();

  get text => _textEditingController.text;
  set settingText(String txt) {
    _textEditingController.text = txt;
  }

  @override
  State<LocationTextField> createState() => _LocationTextFieldState();
}

class _LocationTextFieldState extends State<LocationTextField> {
  bool currentLocationEnabled = false;
  Timer? searchOnStoppedTyping;

  onChangeHandler(String value) {
    value = widget.text;
    if (value.length >= 3 && value.length < 10) {
      searchHandler(value);
    }
  }

  searchHandler(String value) async {
    GoTo.of(context)?.responseState = await searchRequests(value.trim());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 350,
      child: TextField(
        controller: widget._textEditingController,
        onTap: () {
          if (widget.displayCurrentLocation) {
            fromEnabled = true;
          } else {
            fromEnabled = false;
          }
        },
        onChanged: onChangeHandler,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: widget.displayCurrentLocation ? 'From' : 'To',
            suffix: widget.displayCurrentLocation
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        String currentText = !currentLocationEnabled
                            ? '${sharedPreferences.getString('userAddress')}'
                            : '';

                        widget._textEditingController.text = currentText;
                        if (!currentLocationEnabled) {
                          sourceGiven = true;
                          sharedPreferences.setDouble('sourceLat',
                              sharedPreferences.getDouble('latitude')!);
                          sharedPreferences.setDouble('sourceLng',
                              sharedPreferences.getDouble('longitude')!);

                        }

                        currentLocationEnabled = !currentLocationEnabled;
                      });
                    },
                    icon: const Icon(Icons.my_location_rounded),
                    tooltip: 'Current Location',
                  )
                : null,
            contentPadding:
                const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 6.0)),
      ),
    );
  }
}
