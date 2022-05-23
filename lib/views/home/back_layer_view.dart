import 'package:bookledge/models/lookup_model/lookup.dart';
import 'package:bookledge/utility/app_theme.dart';
import 'package:bookledge/views/CustomViews/lookup_dialogs.dart';
import 'package:flutter/material.dart';

class BackLayer extends StatefulWidget {
  const BackLayer({Key? key, required this.context, required this.callback})
      : super(key: key);
  final BuildContext context;
  final Function(int, int) callback;

  @override
  State<BackLayer> createState() => _BackLayerState();
}

class _BackLayerState extends State<BackLayer> {
  Lookup? selectedMedium;
  Lookup? selectedStd;

  var mediumTxt = TextEditingController();
  var stdTxt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return getView();
  }

  Widget getView() {
    return SizedBox(
        height: 300.0,
        child: Center(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: const Text("Choose",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold))),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: mediumTxt,
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                        backgroundColor: Colors.white,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      suffixIconColor: Colors.black,
                      hintText: "Select Medium",
                      border: InputBorder.none,
                    ),
                    onTap: () => mediumClicked(),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: stdTxt,
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                        backgroundColor: Colors.white,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      suffixIconColor: Colors.black,
                      hintText: "Select Class",
                      border: InputBorder.none,
                    ),
                    onTap: () => classClicked(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 40),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.buttonColor),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(200, 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(25.0)))),
                    onPressed: () {
                      if (selectedMedium != null && selectedStd != null) {
                        widget.callback(
                            selectedMedium?.id ?? -1, selectedStd?.id ?? -1);
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ])));
  }

  void mediumClicked() {
    LookupDialogs().openMediumDialog(context, mediumSelected: (medium) {
      setState(() {
        mediumTxt.text = medium.name;
        selectedMedium = medium;
      });
    });
  }

  void classClicked() {
    LookupDialogs().openClassDialog(context, classSelected: (std) {
      setState(() {
        stdTxt.text = std.name;
        selectedStd = std;
      });
    });
  }
}
