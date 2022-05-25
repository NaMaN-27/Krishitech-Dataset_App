import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

String newPath = "";
final picker = ImagePicker();
bool condition = false;
Directory directory;
Directory dir;

String result = '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dataset app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    fileSave();
    super.initState();
  }

  void cam() {
    setState(() {
      condition = true;
    });
  }

  void stop() {
    setState(() {
      condition = false;
    });
  }

  Future<bool> req(Permission per) async {
    if (await per.isGranted) {
      return true;
    } else {
      var result = await per.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  void fileSave() async {
    if (await req(Permission.storage)) {
      directory = await getExternalStorageDirectory();
    }
  }

  void imagesave() async {
    if (await req(Permission.storage)) {
      await name();

      var image = await picker.getImage(source: ImageSource.camera);

      File img = File(image.path);
      final String s = directory.path;
      final String fileExtension = extension(img.path);
      final String Path = '$s/$result$fileExtension';

      bool exist = File(Path).existsSync();
      if (!exist) {
        img.renameSync('$s/$result$fileExtension');
      }

      print("ok");
    }
  }

  Future<String> name() async {
    if ((mobile1 | mobile2) &
        (r1 | r2) &
        (day | night) &
        (i | o) &
        (sparse | overlap) &
        (depth1 | depth2) &
        (image1 | image2) &
        (blue | black | green | inhand | f1 | f2)) {
      err = false;
      print("OK");
      result = "";
      mobile1 ? result = result + "M1" : result = result + "M2";
      r1 ? result = result + "R1" : result = result + "R2";
      day ? result = result + "D" : result = result + "N";
      i ? result = result + "I" : result = result + "O";

      if (blue) {
        result = result + "LB";
      }
      if (green) {
        result = result + "LG";
      }
      if (black) {
        result = result + "BK";
      }
      if (inhand) {
        result = result + "IH";
      }
      if (f1) {
        result = result + "F1";
      }
      if (f2) {
        result = result + "F2";
      }
      sparse ? result = result + "S" : result = result + "O";
      depth1 ? result = result + "D1" : result = result + "D2";
      image1 ? result = result + "_image1" : result = result + "_image2";
      print(result);
    } else {
      err = true;
    }
  }

  bool mobile1 = false;
  bool mobile2 = false;

  bool r1 = false;
  bool r2 = false;

  bool day = false;
  bool night = false;

  bool i = false;
  bool o = false;

  bool sparse = false;
  bool overlap = false;

  bool depth1 = false;
  bool depth2 = false;

  bool image1 = false;
  bool image2 = false;

  bool blue = false;
  bool black = false;
  bool green = false;
  bool inhand = false;
  bool f1 = false;
  bool f2 = false;

  bool err = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text('KRISHITECT'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("M 1"),
                        Switch(
                          value: mobile1,
                          onChanged: (bool value) {
                            setState(() {
                              mobile1 = value;
                              mobile2 = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("M 2"),
                        Switch(
                          value: mobile2,
                          onChanged: (bool value) {
                            setState(() {
                              mobile2 = value;
                              mobile1 = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("R1"),
                        Switch(
                          value: r1,
                          onChanged: (bool value) {
                            setState(() {
                              r1 = value;
                              r2 = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("R2"),
                        Switch(
                          value: r2,
                          onChanged: (bool value) {
                            setState(() {
                              r2 = value;
                              r1 = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("DAY"),
                        Switch(
                          value: day,
                          onChanged: (bool value) {
                            setState(() {
                              day = value;
                              night = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("Night"),
                        Switch(
                          value: night,
                          onChanged: (bool value) {
                            setState(() {
                              night = value;
                              day = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("IN"),
                        Switch(
                          value: i,
                          onChanged: (bool value) {
                            setState(() {
                              i = value;
                              o = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("OUT"),
                        Switch(
                          value: o,
                          onChanged: (bool value) {
                            setState(() {
                              o = value;
                              i = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("Sparse"),
                        Switch(
                          value: sparse,
                          onChanged: (bool value) {
                            setState(() {
                              sparse = value;
                              overlap = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("Overlap"),
                        Switch(
                          value: overlap,
                          onChanged: (bool value) {
                            setState(() {
                              overlap = value;
                              sparse = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("Depth 1"),
                        Switch(
                          value: depth1,
                          onChanged: (bool value) {
                            setState(() {
                              depth1 = value;
                              depth2 = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("image 1"),
                        Switch(
                          value: image1,
                          onChanged: (bool value) {
                            setState(() {
                              image1 = value;
                              image2 = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("image 2"),
                        Switch(
                          value: image2,
                          onChanged: (bool value) {
                            setState(() {
                              image2 = value;
                              image1 = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("Depth 2"),
                        Switch(
                          value: depth2,
                          onChanged: (bool value) {
                            setState(() {
                              depth2 = value;
                              depth1 = !value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text("BACKGROUND :"),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("blue"),
                        Switch(
                          value: blue,
                          onChanged: (bool value) {
                            setState(() {
                              if (blue) {
                                blue = value;
                              } else {
                                blue = value;
                                green = !value;
                                black = !value;
                                inhand = !value;
                                f1 = !value;
                                f2 = !value;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("Green"),
                        Switch(
                          value: green,
                          onChanged: (bool value) {
                            setState(() {
                              if (green) {
                                green = value;
                              } else {
                                green = value;
                                black = !value;
                                inhand = !value;
                                f1 = !value;
                                f2 = !value;
                                blue = !value;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("Black"),
                        Switch(
                          value: black,
                          onChanged: (bool value) {
                            setState(() {
                              if (black) {
                                black = value;
                              } else {
                                black = value;
                                inhand = !value;
                                f1 = !value;
                                f2 = !value;
                                blue = !value;
                                green = !value;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: size.width * 0.8,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("IN HAND"),
                        Switch(
                          value: inhand,
                          onChanged: (bool value) {
                            setState(() {
                              if (inhand) {
                                inhand = value;
                              } else {
                                inhand = value;
                                f1 = !value;
                                f2 = !value;
                                blue = !value;
                                green = !value;
                                black = !value;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("F1"),
                        Switch(
                          value: f1,
                          onChanged: (bool value) {
                            setState(() {
                              if (f1) {
                                f1 = value;
                              } else {
                                f1 = value;

                                f2 = !value;
                                blue = !value;
                                green = !value;
                                black = !value;
                                inhand = !value;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("F2"),
                        Switch(
                          value: f2,
                          onChanged: (bool value) {
                            setState(() {
                              if (f2) {
                                f2 = value;
                              } else {
                                f2 = value;
                                blue = !value;
                                green = !value;
                                black = !value;
                                inhand = !value;
                                f1 = !value;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FloatingActionButton(
                      child: Icon(Icons.camera),
                      onPressed: () async {
                        await name();
                        if (err) {
                          final snackbar =
                              SnackBar(content: Text("SELECT ALL FIELDS"));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } else {
                          final String s = directory.path;
                          final String Path = '$s/$result.jpg';
                          print(Path);
                          bool exist = File(Path).existsSync();
                          if (!exist) {
                            var image = await picker.getImage(
                                source: ImageSource.camera);

                            File img = File(image.path);
                            final String fileExtension = extension(img.path);
                            img.renameSync('$s/$result$fileExtension');
                          } else {
                            final snackba = SnackBar(
                                content: Text("Image With Same Name  Exists"));
                            ScaffoldMessenger.of(context).showSnackBar(snackba);
                          }
                        }
                      },
                      backgroundColor: Colors.pink,
                    )
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
