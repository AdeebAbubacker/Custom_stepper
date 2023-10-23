import 'package:flutter/material.dart';
import 'package:mycustom_stepper_withoutpgview/package/widget/connector.dart';
import 'package:mycustom_stepper_withoutpgview/package/widget/toggleButton.dart';

class CustomStepper extends StatefulWidget {
  final List<AddStep> steps;

  /// Default page that is to be shown when the page loads.
  int currentPage = 1;
  EdgeInsets margin;
  EdgeInsets padding;

  final Map<String, Map<String, double>> uiConfig;
  // final List uiConfig;

  CustomStepper(
      {Key? key,
      required this.steps,
      this.currentPage = 1,
      this.padding = const EdgeInsets.only(left: 0, right: 0),
      this.margin = const EdgeInsets.only(left: 0, right: 0),
      this.uiConfig = const {
        "head": {
          "marginLeft": 15,
          "marginRight": 15,
          "marginTop": 0,
          "marginBottom": 0,
          "paddingLeft": 0,
          "paddingRight": 0,
          "paddingTop": 0,
          "paddingBottom": 0,
        },
        "body": {
          "marginLeft": 0,
          "marginRight": 0,
          "marginTop": 0,
          "marginBottom": 0,
          "paddingLeft": 0,
          "paddingRight": 0,
          "paddingTop": 0,
          "paddingBottom": 0,
        },
      }})
      : super(key: key);

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    List<bool> toggleStates = [];
    double singleCtrLgt = 10;
    int pageLength = widget.steps.length;
    int pageLengthIndex = pageLength - 1;
    toggleStates =
        List.generate(pageLength, (index) => index == widget.currentPage);

    /// we generate +1 as index 0 is never used , we use only from 1
    void onToggleClicked(int page) {
      setState(() {
        widget.currentPage = page;
        for (var i = 0; i < toggleStates.length; i++) {
          toggleStates[i] = i == page;
        }
      });
    }

    void continueStep() {
      if (widget.currentPage < pageLengthIndex) {
        onToggleClicked(widget.currentPage + 1);
      }
    }

    void cancelStep() {
      if (widget.currentPage > 0) {
        onToggleClicked(widget.currentPage - 1);
      }
    }

    ///
    /// This function is used to generate Toggle Buttons & Connectors
    ///
    List<Widget> generateUI() {
      List<Widget> widgets = [];

      for (int index = 0; index <= pageLengthIndex; index++) {
        widgets.add(
          ToggleButton(
            currentStep: '${index + 1}',
            onToggle: () => onToggleClicked(index),
            isActive: toggleStates[index],
          ),
        );

        if (index < pageLengthIndex) {
          widgets.add(Connector(
            width: singleCtrLgt,
          ));
        }
      }

      return widgets;
    }

    var deviceWidth = MediaQuery.of(context).size.width;
    var devicePaddingLeft = 15;
    var devicePaddingRight = 15;
    var tgBtnTotalWidth = 36;
    var tgBtnTotalArea = tgBtnTotalWidth * pageLength;
    var ctrLgt =
        deviceWidth - devicePaddingLeft - devicePaddingRight - tgBtnTotalArea;
    singleCtrLgt = ctrLgt / pageLengthIndex;

    var uiConfig = widget.uiConfig;
    var headUi = uiConfig["head"];
    var bodyUi = uiConfig["body"];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(
                    left: headUi!["marginLeft"] as double,
                    right: headUi["marginRight"] as double,
                    top: headUi["marginTop"] as double,
                    bottom: headUi["marginBottom"] as double),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: generateUI()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(pageLength, (index) {
                  final step = widget.steps[index];
                  final isActive = widget.currentPage == index;
                  return Text(
                    step.title,
                    style: TextStyle(
                        color: isActive
                            ? Colors.blue
                            : const Color.fromARGB(255, 39, 40, 41)),
                  );
                }),
              ),
              Column(
                children: List.generate(pageLength, (index) {
                  return Visibility(
                    visible: widget.currentPage == index,
                    child: Padding(
                      padding: widget.padding,
                      child: Container(
                        margin: widget.margin,
                        child: widget.steps[index].content,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      cancelStep();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      continueStep();
                    },
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddStep {
  final String title;
  final Widget content;

  AddStep({
    required this.title,
    required this.content,
  });
}
