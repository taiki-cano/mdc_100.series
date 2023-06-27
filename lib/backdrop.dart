import 'package:flutter/material.dart';

import 'model/product.dart';
import 'login.dart';

// Add velocity constant (104)
const double _kFlingVelocity = 2.0;

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

// Add _FrontLayer class (104)
class _FrontLayer extends StatelessWidget {
  // TODO: Add on-tap callback (104)
  const _FrontLayer({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // TODO: Add a GestureDetector (104)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(height: 40.0, alignment: AlignmentDirectional.centerStart),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final void Function() onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key? key,
    required Animation<double> listenable,
    required this.onPress,
    required this.frontTitle,
    required this.backTitle,
  })  : _listenable = listenable,
        super(key: key, listenable: listenable);

  final Animation<double> _listenable;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = _listenable;

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.titleLarge!,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(children: <Widget>[
        // branded icon
        SizedBox(
          width: 72.0,
          child: IconButton(
            padding: const EdgeInsets.only(right: 8.0),
            onPressed: onPress,
            icon: Stack(children: <Widget>[
              Opacity(
                opacity: animation.value,
                child: const ImageIcon(AssetImage('assets/slanted_menu.png')),
              ),
              FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(1.0, 0.0),
                ).evaluate(animation),
                child: const ImageIcon(AssetImage('assets/diamond.png')),
              )
            ]),
          ),
        ),
        Stack(
          children: <Widget>[
            Opacity(
              opacity: CurvedAnimation(
                parent: ReverseAnimation(animation),
                curve: const Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(0.5, 0.0),
                ).evaluate(animation),
                child: Semantics(
                    label: 'hide categories menu', child: ExcludeSemantics(child: backTitle)),
              ),
            ),
            Opacity(
              opacity: CurvedAnimation(
                parent: animation,
                curve: const Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: const Offset(-0.25, 0.0),
                  end: Offset.zero,
                ).evaluate(animation),
                child: Semantics(
                    label: 'show categories menu', child: ExcludeSemantics(child: frontTitle)),
              ),
            ),
          ],
        )
      ]),
    );
  }
}

// TODO: Add _BackdropState class (104)
// Add _BackdropState class (104)
class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  // Add AnimationController widget (104)
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 1.0,
    );
  }

  @override
  void didUpdateWidget(covariant Backdrop oldWidget) {
    // implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.currentCategory != oldWidget.currentCategory) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Add functions to get and change front layer visibility (104)
  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  // Add BuildContext and BoxConstraints parameters to _buildStack (104)
  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        // Wrap backLayer in an ExcludeSemantics widget (104)
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible, //_FrontLayer(child: widget.frontLayer),
        ),
        PositionedTransition(
          rect: layerAnimation,
          child: _FrontLayer(
            onTap: _toggleBackdropLayerVisibility,
            child: widget.frontLayer,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      // centerTitle: true,
      // TODO: Replace leading menu icon with IconButton (104)
      // TODO: Remove leading property (104)
      // TODO: Create title with _BackdropTitle parameter (104)

      // leadingWidth: 86,
      // leading: FittedBox(
      //   child: Row(
      //     children: [
      //       IconButton(
      //           onPressed: () => Navigator.pushNamed(context, '/login'),
      //           icon: const Icon(Icons.arrow_back_ios_new)),
      //       IconButton(
      //         onPressed: _toggleBackdropLayerVisibility,
      //         icon: const Icon(Icons.menu),
      //       ),
      //       // IconButton(
      //       //     onPressed: () {
      //       //       print('forward');
      //       //     },
      //       //     icon: Icon(Icons.arrow_forward_ios)),
      //     ],
      //   ),
      // ),
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

      title: _BackdropTitle(
        listenable: _controller.view,
        onPress: _toggleBackdropLayerVisibility,
        frontTitle: widget.frontTitle,
        backTitle: widget.backTitle,
      ),

      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
            semanticLabel: 'login',
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => const LoginPage()),
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.tune,
            semanticLabel: 'login',
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => const LoginPage()),
            );
          },
        ),
      ],
      // actions: <Widget>[
      //   // TODO: Add shortcut to login screen from trailing icons (104)
      //   IconButton(
      //     icon: const Icon(
      //       Icons.search,
      //       semanticLabel: 'search',
      //     ),
      //     onPressed: () {
      //       // TODO: Add open login (104)
      //     },
      //   ),
      //   IconButton(
      //     icon: const Icon(
      //       Icons.tune,
      //       semanticLabel: 'filter',
      //     ),
      //     onPressed: () {
      //       // TODO: Add open login (104)
      //     },
      //   ),
      // ],
    );
    return Scaffold(
      appBar: appBar,
      // Return a LayoutBuilder widget (104)
      body: LayoutBuilder(builder: _buildStack),
      // SafeArea(
      //   child: _buildStack(),
      // ),
    );
  }
}
