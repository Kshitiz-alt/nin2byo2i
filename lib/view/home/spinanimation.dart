// // import 'package:flutter/material.dart';

// // class SpinImageOnNavigate extends StatefulWidget {
// //   @override
// //   _SpinImageOnNavigateState createState() => _SpinImageOnNavigateState();
// // }

// // class _SpinImageOnNavigateState extends State<SpinImageOnNavigate>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controlleranimation;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controlleranimation = AnimationController(
// //       vsync: this,
// //       duration: Duration(seconds: 5), // Changed the duration to 2 seconds
// //     );

// //     _controlleranimation.forward(
// //         from: 0.0); // Start the animation from the beginning
// //   }

// //   @override
// //   void dispose() {
// //     _controlleranimation.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return RotationTransition(
// //       turns: _controlleranimation,
// //       child: Image.asset(
// //         'assets/img/spinanimation.png',
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// class SpinImageOnNavigate extends StatefulWidget {
//   @override
//   _SpinImageOnNavigateState createState() => _SpinImageOnNavigateState();
// }

// class _SpinImageOnNavigateState extends State<SpinImageOnNavigate>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controlleranimation;

//   @override
//   void initState() {
//     super.initState();
//     _controlleranimation = AnimationController(
//       vsync: this,
//       duration: Duration(
//           seconds: 5), // Increase the duration to 5 seconds for slower spin
//     );

//     _controlleranimation.forward(
//         from: 0.0); // Start the animation from the beginning
//   }

//   @override
//   void dispose() {
//     _controlleranimation.dispose();
//     super.dispose();
//   }

//   void _stopSpin() {
//     _controlleranimation.stop(); // Stop the spin animation
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _stopSpin, // Call _stopSpin() when clicked
//       child: RotationTransition(
//         turns: _controlleranimation,
//         child: Image.asset(
//           'assets/img/spinanimation.png',
//         ),
//       ),
//     );
//   }
// // }
// import 'dart:math' as math;
// import 'package:flutter/material.dart';

// class SpinImageOnNavigate extends StatefulWidget {
//   @override
//   _SpinImageOnNavigateState createState() => _SpinImageOnNavigateState();
// }

// class _SpinImageOnNavigateState extends State<SpinImageOnNavigate> {
//   late double _rotation = 0.0;
//   late Offset _startPosition;

//   void _onPanStart(DragStartDetails details) {
//     _startPosition = details.localPosition;
//   }

//   void _onPanUpdate(DragUpdateDetails details) {
//     final currentPosition = details.localPosition;
//     final angleChange = math.atan2(
//       currentPosition.dy - _startPosition.dy,
//       currentPosition.dx - _startPosition.dx,
//     );
//     final distance = (_startPosition - currentPosition).distance;
//     final speedFactor = 0.01; // Adjust the speed factor as needed
//     setState(() {
//       _rotation += angleChange * distance * speedFactor;
//       _startPosition = currentPosition;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanStart: _onPanStart,
//       onPanUpdate: _onPanUpdate,
//       child: Transform.rotate(
//         angle: _rotation,
//         child: Image.asset(
//           'assets/img/spinanimation.png',
//         ),
//       ),
//     );
//   }
// // }
// import 'dart:async';
// import 'dart:math' as math;
// import 'package:flutter/material.dart';

// class SpinImageOnNavigate extends StatefulWidget {
//   @override
//   _SpinImageOnNavigateState createState() => _SpinImageOnNavigateState();
// }

// class _SpinImageOnNavigateState extends State<SpinImageOnNavigate> {
//   late double _rotation = 0.0;
//   late Offset _startPosition;
//   bool _isRotating = true;

//   @override
//   void initState() {
//     super.initState();
//     // Start rotating the image for 2 seconds
//     Timer(Duration(seconds: 2), () {
//       setState(() {
//         _isRotating = false;
//       });
//     });

//     Timer.periodic(Duration(milliseconds: 16), (_) {
//       if (_isRotating) {
//         setState(() {
//           _rotation += 0.01; // Adjust the speed of rotation as needed
//         });
//       }
//     });
//   }

//   void _onPanStart(DragStartDetails details) {
//     _startPosition = details.localPosition;
//   }

//   void _onPanUpdate(DragUpdateDetails details) {
//     final currentPosition = details.localPosition;
//     final angleChange = math.atan2(
//       currentPosition.dy - _startPosition.dy,
//       currentPosition.dx - _startPosition.dx,
//     );
//     final distance = (_startPosition - currentPosition).distance;
//     final speedFactor = 0.01; // Adjust the speed factor as needed
//     setState(() {
//       _rotation += angleChange * distance * speedFactor;
//       _startPosition = currentPosition;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return Container(
//       child: GestureDetector(
//         onPanStart: _onPanStart,
//         onPanUpdate: _onPanUpdate,
//         child: Transform.rotate(
//           angle: _rotation,
//           child: Image.asset(
//             // 'assets/img/spinanimation.png',
//             'assets/img/my plate PNG final.png',
//           ),
//         ),
//       ),
//     );
//   }
// }

//spin animation page
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class SpinImageOnNavigate extends StatefulWidget {
  const SpinImageOnNavigate({super.key});

  @override
  _SpinImageOnNavigateState createState() => _SpinImageOnNavigateState();
}

class _SpinImageOnNavigateState extends State<SpinImageOnNavigate> {
  late double _rotation = 0.0;
  late Offset _startPosition;
  final bool _isRotating = true;
  late Timer _rotationTimer;
  @override
  void initState() {
    super.initState();

    _rotationTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (_isRotating) {
        setState(() {
          _rotation += 0.001; // Adjust the speed of rotation as needed
        });
      }
    });
  }

  @override
  void dispose() {
    _rotationTimer
        .cancel(); // Cancel the timer to prevent setState() after dispose
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _startPosition = details.localPosition;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final currentPosition = details.localPosition;
    final angleChange = math.atan2(
      currentPosition.dy - _startPosition.dy,
      currentPosition.dx - _startPosition.dx,
    );
    final distance = (_startPosition - currentPosition).distance;
    const speedFactor = 0.01; // Adjust the speed factor as needed
    setState(() {
      _rotation += angleChange * distance * speedFactor;
      _startPosition = currentPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      child: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        child: Transform.rotate(
          angle: _rotation,
          child: Image.asset(
            'assets/img/plateindividual.png',
          ),
        ),
      ),
    );
  }
}
