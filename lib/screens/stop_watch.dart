import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_task/utils/app_utils.dart';

class StopWatch extends StatefulWidget {
  final Function(Duration duration) onNewTaskEnd;

  const StopWatch({required this.onNewTaskEnd, Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Duration duration = const Duration();
  Timer? timer;
  Position? _userPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determineUserPosition();
  }

  _listenCurrentLocation() async {
    Geolocator.getPositionStream().listen((position) {});
  }

  bool _isProjectInRadius() {
    bool isProjectFound = false;
    try {
      if (_userPosition != null) {
        double distance = Geolocator.distanceBetween(_userPosition!.latitude, _userPosition!.longitude, AppUtils.projectLat, AppUtils.projectLong);

        if (distance <= 10) {
          isProjectFound = true;
        }
      }
    } catch (e) {
      debugPrint("e");
    }
    return isProjectFound;
  }

  Future<Position?> _determineUserPosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error('Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      _userPosition = await Geolocator.getCurrentPosition();
      _listenCurrentLocation();
      return _userPosition;
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }

  void reset() {
    widget.onNewTaskEnd(duration);
    setState(() => duration = const Duration());
  }

  void startTimer() {
    if (mounted) {
      setState(() {
        timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
      });
    }
  }

  void addTime() {
    setState(() {
      final seconds = duration.inSeconds + 1;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        if (_isProjectInRadius()) {
          duration = Duration(seconds: seconds);
        } else {
          timer?.cancel();
        }
      }
    });
  }

  void stopTimer({bool resets = true}) {
    if (duration.inSeconds > 0) {
      if (resets) {
        reset();
      }
      setState(() => timer?.cancel());
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTime(),
            const SizedBox(
              height: 80,
            ),
            buildButtons()
          ],
        ),
      );

  Widget buildTime() {
    final minutes = AppUtils.twoDigits(duration.inMinutes);
    final seconds = AppUtils.twoDigits(duration.inSeconds.remainder(60));
    return Text(
      "$minutes:$seconds",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget buildButtons() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if ((timer?.isActive ?? false)) {
              stopTimer(resets: false);
            } else {
              startTimer();
            }
          },
          icon: Icon(
            (timer?.isActive ?? false) ? Icons.pause : Icons.play_circle_outline,
          ),
          iconSize: 24,
        ),
        IconButton(
          onPressed: stopTimer,
          icon: const Icon(Icons.stop),
          iconSize: 24,
        )
      ],
    );
  }
}
