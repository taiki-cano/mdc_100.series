import 'package:flutter/material.dart';

import 'model/product.dart';

// TODO: Add velocity constant (104)

class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    required this.currentCategory,
    required this.frontLayer,
    required this.backLayer,
    required this.frontTitle,
    required this.backTitle,
    Key? key,
  }) : super(key: key);

  @override
  _BackdropState createState() => _BackdropState();
}

// TODO: Add _FrontLayer class (104)
// TODO: Add _BackdropTitle class (104)
// TODO: Add _BackdropState class (104)

// Add _BackdropState class (104)
class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  // TODO: Add AnimationController widget (104)

  // TODO: Add BuildContext and BoxConstraints parameters to _buildStack (104)
  Widget _buildStack() {
    return Stack(
      key: _backdropKey,
      children: <Widget>[
        // TODO: Wrap backLayer in an ExcludeSemantics widget (104)
        widget.backLayer,
        widget.frontLayer,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
      // TODO: Replace leading menu icon with IconButton (104)
      // TODO: Remove leading property (104)
      // TODO: Create title with _BackdropTitle parameter (104)
      leadingWidth: 86,
      leading: FittedBox(
        child: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                icon: const Icon(Icons.arrow_back_ios_new)),
            // IconButton(
            //     onPressed: () {
            //       print('forward');
            //     },
            //     icon: Icon(Icons.arrow_forward_ios)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
      ),
      // title: Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.arrow_back_ios),
      //       // iconSize: 10,
      //     ),
      //     Stack(
      //       alignment: Alignment.center,
      //       children: [
      //         IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      //         Positioned(
      //           top: 12.0,
      //           right: 10.0,
      //           width: 10.0,
      //           height: 10.0,
      //           child: Container(
      //             decoration: const BoxDecoration(
      //               shape: BoxShape.circle,
      //               color: Colors.red, // color: AppColors.notification,
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //     const Expanded(
      //         child: Center(
      //       child: Text('SHRINE'),
      //     )),
      //   ],
      // ),
      title: const Text('SHRINE'),
      actions: <Widget>[
        // TODO: Add shortcut to login screen from trailing icons (104)
        IconButton(
          icon: const Icon(
            Icons.search,
            semanticLabel: 'search',
          ),
          onPressed: () {
            // TODO: Add open login (104)
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.tune,
            semanticLabel: 'filter',
          ),
          onPressed: () {
            // TODO: Add open login (104)
          },
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      // TODO: Return a LayoutBuilder widget (104)
      body: _buildStack(),
    );
  }
}
