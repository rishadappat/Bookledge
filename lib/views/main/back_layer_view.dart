import 'package:bookledge/models/lookup_model/lookup.dart';
import 'package:bookledge/utility/app_theme.dart';
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
    showModalBottomSheet(
        isScrollControlled: true,
        context: widget.context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return SafeArea(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.remove,
                color: Colors.grey[600],
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text("Medium",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
              ),
              ListTile(
                leading: ImageIcon(
                  const AssetImage("lib/assets/mal.png"),
                  color: AppTheme.accentColor,
                ),
                title: const Text('Malayalam',
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  setState(() {
                    selectedMedium = Lookup(
                        name: 'Malayalam', id: 1, logo: "lib/assets/mal.png");
                    mediumTxt.text = selectedMedium?.name ?? "";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: ImageIcon(
                  const AssetImage("lib/assets/en.png"),
                  color: AppTheme.accentColor,
                ),
                title: const Text('English',
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  setState(() {
                    selectedMedium = Lookup(
                        name: 'English', id: 2, logo: "lib/assets/en.png");
                    mediumTxt.text = selectedMedium?.name ?? "";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: ImageIcon(
                  const AssetImage("lib/assets/tam.png"),
                  color: AppTheme.accentColor,
                ),
                title:
                    const Text('Tamil', style: TextStyle(color: Colors.black)),
                onTap: () {
                  setState(() {
                    selectedMedium = Lookup(
                        name: 'Tamil', id: 3, logo: "lib/assets/tam.png");
                    mediumTxt.text = selectedMedium?.name ?? "";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: ImageIcon(
                  const AssetImage("lib/assets/kan.png"),
                  color: AppTheme.accentColor,
                ),
                title: const Text('Kannada',
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  setState(() {
                    selectedMedium = Lookup(
                        name: 'Kannada', id: 4, logo: "lib/assets/kan.png");
                    mediumTxt.text = selectedMedium?.name ?? "";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ));
        });
  }

  Widget getNumberDigitIcon(int number) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppTheme.primaryColor),
      margin: const EdgeInsets.only(top: 5),
      child: Text(
        "$number",
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  void classClicked() {
    showModalBottomSheet(
      context: widget.context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        expand: false,
        builder: (_, controller) => Column(
          children: [
            Icon(
              Icons.remove,
              color: Colors.grey[600],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const Text("Standard",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: 12,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: getNumberDigitIcon(index + 1),
                    title: Text("Standard ${index + 1}",
                        style: const TextStyle(
                          color: Colors.black,
                        )),
                    onTap: () {
                      setState(() {
                        stdTxt.text = "Standard ${index + 1}";
                        selectedStd = Lookup(
                            name: "Standard ${index + 1}",
                            id: index + 1,
                            logo: "");
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
