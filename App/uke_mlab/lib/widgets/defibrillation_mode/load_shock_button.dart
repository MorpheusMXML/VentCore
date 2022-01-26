import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/providers/sound_controller.dart';

/// This Class implements the 2-in-1 Button for the Loading and Shock applying behaviour of the Defibrillator.
/// #### Important Note: This Is a [StatefulWidget] this is necessary to adequately Animate the change for Loading the Defibrillator.
///
/// When this Class is Instanciated, the [initState()] Method for this Widget creates an Instance of [AnimationController] and [ColorTween].
/// The ColorTween sets the Color Transition for the Animation from [Colors.transparent] to [Colors.red] and registeres it at the [_animationController].
/// The [AnimationController] sets a [Duration] of 6 Seconds to fit the corresponding Sound Effect while Loading the Defi.
///
/// This Class also [Get]'s the [DefibrillationController] and [SoundController] Instances with [Get.find] in order to Trigger the Sound Effects
/// of the Defibrillator and set the State of the Defibrillation Settings.
///
/// ### Behaviour of the Button:
/// The Defibrillator is loaded with a short Click on the Button. After this, the Loading Sound is triggered
/// at the [SoundController] with [soundController.playDefiLoadSound()].
/// Also the State of the Defi is changed to 'ReadyToShock'. When the Color Animation is finished, the Alarm for the Armed Defi is played in Loop Mode.
/// Also the SVG for the Icon is changed from the Battery to the Lightning Icon.
///
/// After the Defi is Loaded and ReadyToShock, one can apply the Shock with a Long Press on the Shock Button. This will Cancel the Spund Effect of the Armed Defi,
///  reset the Color Animation back to Transparent and change the Icon back to the Battery.
/// #### Note that the [defibrillationController.toggleButtonAvailable.toggle()] call with the Press and LongPress Callback disables
/// the Functionallity of the [ToggleModeButton] for changing the Mode of the Device.
/// This is due to a Bug that will cause the app to crash when Animating a Widget while changing the Screen Mode.
/// Further for Safety Reasons one should not be able to change the Mode of the Device when the User is Loading the Defibrillator and / or ready to apply the Shock.
class LoadShockButton extends StatefulWidget {
  const LoadShockButton({Key? key}) : super(key: key);

  @override
  _LoadShockButtonState createState() => _LoadShockButtonState();
}

/// This implements the State for the [LoadShockButton]. Initializes a [AnimationController] and registeres a [ColorTween] with it. These initializations are called with [initState()].
/// Holds a Reference to the [DefibrillationController], [SoundController] and Renders a [ElevatedButton] from the Information in the DefiController.
/// Implements the Long Press and Short Press behaviour.
class _LoadShockButtonState extends State<LoadShockButton>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 6,
      ),
    );
    _colorTween = ColorTween(
      begin: Colors.transparent,
      end: Colors.red,
    ).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  DefibrillationController defibrillationController =
      Get.find<DefibrillationController>();
  SoundController soundController = Get.find<SoundController>();
  late AnimationController _animationController;
  late Animation<Color?> _colorTween;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: AnimatedBuilder(
        animation: _colorTween,
        builder: (BuildContext _, Widget? __) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: _colorTween.value,
              onPrimary: _colorTween.value,
              side: const BorderSide(
                color: Colors.green,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: _colorTween.value,
                  child: (_animationController.isCompleted &&
                          defibrillationController.isReadyToShock == true)
                      ? SvgPicture.asset('assets/icons/Shock.svg')
                      : SvgPicture.asset('assets/icons/Battery.svg'),
                  padding: const EdgeInsets.all(8),
                ),
                const Text('Load'),
              ],
            ),
            onPressed: () {
              setState(
                () {
                  if (!defibrillationController.isReadyToShock) {
                    //Disable ToggleButton for Safety Reasons because Mode Change shall be Blocked during Shock Loading and Ready to Shock State
                    defibrillationController.toggleButtonAvailable.toggle();
                    soundController.playDefiLoadSound();
                    _animationController.forward();
                    defibrillationController.isReadyToShock = true;
                  }
                },
              );
            },
            onLongPress: () {
              setState(() {
                if (defibrillationController.isReadyToShock) {
                  soundController.stop();
                  soundController.startSaturationHFSound();
                  _animationController.reset();
                  defibrillationController.startLastWatch();
                  defibrillationController.numberOfShocks++;
                  defibrillationController.isReadyToShock = false;
                  // Enable ToggleButton after Shock has been dicharged.
                  defibrillationController.toggleButtonAvailable.toggle();
                } else {
                  defibrillationController.toggleButtonAvailable.toggle();
                  soundController.playDefiLoadSound();
                  _animationController.forward();
                  defibrillationController.isReadyToShock = true;
                }
              });
            },
          );
        },
        child: const Icon(Icons.aspect_ratio),
      ),
    );
  }
}
