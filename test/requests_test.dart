
import 'package:flutter_test/flutter_test.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_turn_by_turn/data/maps/mapbox_direction_requests.dart';

void main() {
  group('APIs testing', () {
    test('API_1 test', () {
      expect('actual', 'matcher');
    });

    test('API_2 test', () {
      expect('actual', 'matcher');
    });
  });

  
  test('To verify the directions given by API', () {
    expect(
        directionsApiRequest(
            cor1: const LatLng(40.6563, 73.9600),
            cor2: const LatLng(40.656284, 73.9593)),
        Future.value({
          "routes": [
            {
              "weight_name": "auto",
              "weight": 820.624,
              "duration": 179.247,
              "distance": 749.11,
              "legs": [
                {
                  "via_waypoints": [],
                  "admins": [
                    {"iso_3166_1_alpha3": "USA", "iso_3166_1": "US"}
                  ],
                  "weight": 820.624,
                  "duration": 179.247,
                  "steps": [
                    {
                      "intersections": [
                        {
                          "entry": [true],
                          "bearings": [349],
                          "duration": 3.464,
                          "mapbox_streets_v8": {"class": "primary"},
                          "is_urban": true,
                          "admin_index": 0,
                          "out": 0,
                          "weight": 3.81,
                          "geometry_index": 0,
                          "location": [-73.960028, 40.656309]
                        },
                        {
                          "entry": [false, false, false, true],
                          "in": 1,
                          "bearings": [89, 169, 267, 349],
                          "duration": 1.447,
                          "turn_duration": 0.007,
                          "mapbox_streets_v8": {"class": "primary"},
                          "is_urban": true,
                          "admin_index": 0,
                          "out": 3,
                          "weight": 1.584,
                          "geometry_index": 1,
                          "location": [-73.960059, 40.656433]
                        },
                        {
                          "entry": [false, false, true],
                          "in": 1,
                          "bearings": [86, 169, 350],
                          "duration": 3.808,
                          "turn_duration": 2.008,
                          "traffic_signal": true,
                          "mapbox_streets_v8": {"class": "primary"},
                          "is_urban": true,
                          "admin_index": 0,
                          "out": 2,
                          "weight": 1.98,
                          "geometry_index": 2,
                          "location": [-73.960073, 40.656486]
                        },
                        {
                          "entry": [false, false, false, true],
                          "in": 1,
                          "bearings": [89, 170, 269, 350],
                          "duration": 4.207,
                          "turn_duration": 0.007,
                          "mapbox_streets_v8": {"class": "primary"},
                          "is_urban": true,
                          "admin_index": 0,
                          "out": 3,
                          "weight": 4.62,
                          "geometry_index": 3,
                          "location": [-73.960091, 40.656567]
                        },
                        {
                          "bearings": [170, 259, 350],
                          "entry": [false, true, true],
                          "in": 0,
                          "turn_duration": 0.007,
                          "mapbox_streets_v8": {"class": "primary"},
                          "is_urban": true,
                          "admin_index": 0,
                          "out": 2,
                          "geometry_index": 4,
                          "location": [-73.960135, 40.656757]
                        }
                      ],
                      "maneuver": {
                        "type": "depart",
                        "instruction": "Drive north on Flatbush Avenue.",
                        "bearing_after": 349,
                        "bearing_before": 0,
                        "location": [-73.960028, 40.656309]
                      },
                      "name": "Flatbush Avenue",
                      "duration": 23.165,
                      "distance": 104.305,
                      "driving_side": "right",
                      "weight": 23.249,
                      "mode": "driving",
                      "geometry": {
                        "coordinates": [
                          [-73.960028, 40.656309],
                          [-73.960059, 40.656433],
                          [-73.960073, 40.656486],
                          [-73.960091, 40.656567],
                          [-73.960135, 40.656757],
                          [-73.960243, 40.657232]
                        ],
                        "type": "LineString"
                      }
                    },
                    {
                      "intersections": [
                        {
                          "entry": [true, false, true],
                          "in": 1,
                          "bearings": [85, 170, 351],
                          "duration": 4.535,
                          "turn_weight": 7,
                          "turn_duration": 2.535,
                          "mapbox_streets_v8": {"class": "street"},
                          "is_urban": true,
                          "admin_index": 0,
                          "out": 0,
                          "weight": 9.2,
                          "geometry_index": 5,
                          "location": [-73.960243, 40.657232]
                        },
                        {
                          "entry": [true, false, false, false],
                          "in": 2,
                          "bearings": [85, 169, 265, 349],
                          "duration": 58.819,
                          "turn_weight": 2,
                          "turn_duration": 0.019,
                          "mapbox_streets_v8": {"class": "street"},
                          "is_urban": true,
                          "admin_index": 0,
                          "out": 0,
                          "weight": 66.68,
                          "geometry_index": 6,
                          "location": [-73.960121, 40.65724]
                        },
                        {
                          "bearings": [85, 173, 265, 353],
                          "entry": [true, false, false, false],
                          "in": 2,
                          "turn_weight": 2,
                          "turn_duration": 0.019,
                          "mapbox_streets_v8": {"class": "street"},
                          "is_urban": true,
                          "admin_index": 0,
                          "out": 0,
                          "geometry_index": 9,
                          "location": [-73.956654, 40.657448]
                        }
                      ],
                      "maneuver": {
                        "type": "turn",
                        "instruction": "Turn right onto Hawthorne Street.",
                        "modifier": "right",
                        "bearing_after": 85,
                        "bearing_before": 350,
                        "location": [-73.960243, 40.657232]
                      },
                      "name": "Hawthorne Street",
                      "duration": 64.973,
                      "distance": 312.176,
                      "driving_side": "right",
                      "weight": 79.64,
                      "mode": "driving",
                      "geometry": {
                        "coordinates": [
                          [-73.960243, 40.657232],
                          [-73.960121, 40.65724],
                          [-73.95937, 40.657285],
                          [-73.957795, 40.657379],
                          [-73.956654, 40.657448],
                          [-73.956558, 40.657454]
                        ],
                        "type": "LineString"
                      }
                    },
                    {
                      "intersections": [
                        {
                          "mapbox_streets_v8": {"class": "tertiary"},
                          "location": [-73.956558, 40.657454],
                          "geometry_index": 10,
                          "admin_index": 0,
                          "weight": 9.165,
                          "is_urban": true,
                          "traffic_signal": true,
                          "turn_duration": 4.208,
                          "turn_weight": 8,
                          "duration": 5.267,
                          "bearings": [86, 176, 265, 356],
                          "out": 1,
                          "in": 2,
                          "entry": [true, true, false, true]
                        },
                        {
                          "entry": [false, true, false, false],
                          "in": 3,
                          "bearings": [84, 175, 266, 356],
                          "duration": 14.843,
                          "turn_weight": 1.5,
                          "turn_duration": 0.019,
                          "mapbox_streets_v8": {"class": "tertiary"},
                          "is_urban": true,
                          "admin_index": 0,
                          "out": 1,
                          "weight": 17.806,
                          "geometry_index": 11,
                          "location": [-73.956553, 40.657405]
                        },
                        {
                          "bearings": [84, 175, 265, 355],
                          "entry": [false, true, false, false],
                          "in": 3,
                          "turn_weight": 1.5,
                          "turn_duration": 0.007,
                          "mapbox_streets_v8": {"class": "tertiary"},
                          "is_urban": true,
                          "admin_index": 0,
                          "out": 1,
                          "geometry_index": 12,
                          "location": [-73.956486, 40.656782]
                        }
                      ],
                      "maneuver": {
                        "type": "turn",
                        "instruction": "Turn right onto Bedford Avenue.",
                        "modifier": "right",
                        "bearing_after": 176,
                        "bearing_before": 85,
                        "location": [-73.956558, 40.657454]
                      },
                      "name": "Bedford Avenue",
                      "duration": 21.811,
                      "distance": 82.986,
                      "driving_side": "right",
                      "weight": 30.334,
                      "mode": "driving",
                      "geometry": {
                        "coordinates": [
                          [-73.956558, 40.657454],
                          [-73.956553, 40.657405],
                          [-73.956486, 40.656782],
                          [-73.956478, 40.656711]
                        ],
                        "type": "LineString"
                      }
                    },
                    {
                      "intersections": [
                        {
                          "mapbox_streets_v8": {"class": "street"},
                          "location": [-73.956478, 40.656711],
                          "geometry_index": 13,
                          "admin_index": 0,
                          "weight": 9.227,
                          "is_urban": true,
                          "traffic_signal": true,
                          "turn_duration": 4.105,
                          "turn_weight": 7,
                          "duration": 6.13,
                          "bearings": [84, 176, 265, 355],
                          "out": 2,
                          "in": 3,
                          "entry": [false, true, true, false]
                        },
                        {
                          "bearings": [85, 170, 265, 351],
                          "entry": [false, false, true, false],
                          "in": 0,
                          "turn_weight": 2,
                          "turn_duration": 0.007,
                          "mapbox_streets_v8": {"class": "street"},
                          "is_urban": true,
                          "admin_index": 0,
                          "out": 2,
                          "geometry_index": 14,
                          "location": [-73.956585, 40.656704]
                        }
                      ],
                      "maneuver": {
                        "type": "turn",
                        "instruction": "Turn right onto Winthrop Street.",
                        "modifier": "right",
                        "bearing_after": 265,
                        "bearing_before": 175,
                        "location": [-73.956478, 40.656711]
                      },
                      "name": "Winthrop Street",
                      "duration": 54.288,
                      "distance": 222.601,
                      "driving_side": "right",
                      "weight": 64.192,
                      "mode": "driving",
                      "geometry": {
                        "coordinates": [
                          [-73.956478, 40.656711],
                          [-73.956585, 40.656704],
                          [-73.959105, 40.656547]
                        ],
                        "type": "LineString"
                      }
                    },
                    {
                      "intersections": [
                        {
                          "bearings": [85, 175, 265],
                          "entry": [false, true, true],
                          "classes": ["restricted"],
                          "in": 0,
                          "turn_weight": 612.5,
                          "turn_duration": 5.275,
                          "mapbox_streets_v8": {"class": "service"},
                          "is_urban": true,
                          "admin_index": 0,
                          "out": 1,
                          "geometry_index": 15,
                          "location": [-73.959105, 40.656547]
                        }
                      ],
                      "maneuver": {
                        "type": "turn",
                        "instruction": "Turn left.",
                        "modifier": "left",
                        "bearing_after": 175,
                        "bearing_before": 265,
                        "location": [-73.959105, 40.656547]
                      },
                      "name": "",
                      "duration": 15.01,
                      "distance": 27.042,
                      "driving_side": "right",
                      "weight": 623.209,
                      "mode": "driving",
                      "geometry": {
                        "coordinates": [
                          [-73.959105, 40.656547],
                          [-73.959075, 40.656305]
                        ],
                        "type": "LineString"
                      }
                    },
                    {
                      "intersections": [
                        {
                          "bearings": [355],
                          "entry": [true],
                          "in": 0,
                          "admin_index": 0,
                          "geometry_index": 16,
                          "location": [-73.959075, 40.656305]
                        }
                      ],
                      "maneuver": {
                        "type": "arrive",
                        "instruction": "Your destination is on the right.",
                        "modifier": "right",
                        "bearing_after": 0,
                        "bearing_before": 175,
                        "location": [-73.959075, 40.656305]
                      },
                      "name": "",
                      "duration": 0,
                      "distance": 0,
                      "driving_side": "right",
                      "weight": 0,
                      "mode": "driving",
                      "geometry": {
                        "coordinates": [
                          [-73.959075, 40.656305],
                          [-73.959075, 40.656305]
                        ],
                        "type": "LineString"
                      }
                    }
                  ],
                  "distance": 749.11,
                  "summary": "Hawthorne Street, Winthrop Street"
                }
              ],
              "geometry": {
                "coordinates": [
                  [-73.960028, 40.656309],
                  [-73.960243, 40.657232],
                  [-73.956558, 40.657454],
                  [-73.956478, 40.656711],
                  [-73.959105, 40.656547],
                  [-73.959075, 40.656305]
                ],
                "type": "LineString"
              }
            }
          ],
          "waypoints": [
            {
              "distance": 2.007,
              "name": "Flatbush Avenue",
              "location": [-73.960028, 40.656309]
            },
            {
              "distance": 24.959,
              "name": "",
              "location": [-73.959075, 40.656305]
            }
          ],
          "code": "Ok",
          "uuid": "kVl4zjPsDAriaIdDyPnXqNm6QBVTMZXWTL6yO0eIYE4YyZGD-eCWEg=="
        }));
  });
}
