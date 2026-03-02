import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final int numDots = 4;
  int _activeDotIndex = 1;

  final imageUrl =
      'https://avatars.githubusercontent.com/u/93799115?s=400&u=c14fd1eee86f09a50970fa9f856cb2e48d17191c&v=4';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _activeDotIndex = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 40,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                imageUrl,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Developer: Wachu985',
              style: TextTheme.of(context).titleLarge,
            ),

            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFF6F6F9),
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtomAction(
                      backgroundColor: Color(0xFFDAD9E4),
                      icon: Icons.arrow_back_ios_new_outlined,
                      iconColor: Colors.deepPurple,
                      action: () {
                        setState(() {
                          _activeDotIndex = (_activeDotIndex - 1) % numDots;
                        });
                      },
                    ),

                    ...List.generate(
                      numDots,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: IndicatorDots(
                          isActive: index == _activeDotIndex,
                          onEnd: () {
                            setState(() {
                              _activeDotIndex = (_activeDotIndex + 1) % numDots;
                            });
                          },
                        ),
                      ),
                    ),

                    ButtomAction(
                      backgroundColor: Color(0xFF2B2B2E),
                      icon: Icons.arrow_forward_ios_outlined,
                      iconColor: Colors.white,
                      action: () {
                        setState(() {
                          _activeDotIndex = (_activeDotIndex + 1) % numDots;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IndicatorDots extends StatelessWidget {
  const IndicatorDots({super.key, required this.isActive, required this.onEnd});

  final bool isActive;
  final VoidCallback onEnd;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 900),
      padding: EdgeInsets.all(5),
      width: isActive ? 70 : 20,
      height: 20,
      curve: Curves.elasticOut,
      decoration: BoxDecoration(
        color: Color(0xFFDAD9E4),
        borderRadius: BorderRadius.all(Radius.circular(80)),
      ),
      child: Align(
        alignment: AlignmentGeometry.centerLeft,
        child: AnimatedContainer(
          onEnd: isActive ? onEnd : null,
          duration: Duration(seconds: 3),
          width: isActive ? 60 : 10,
          child: Container(
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(80)),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtomAction extends StatelessWidget {
  const ButtomAction({
    super.key,
    required this.icon,
    required this.action,
    required this.iconColor,
    required this.backgroundColor,
  });

  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(80)),
        ),
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
