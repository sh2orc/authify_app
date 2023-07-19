import 'package:authify_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../utils/animations/login_page_animation.dart';
import '../utils/animations/page_routes/fade_page_route.dart';

class AnimatedHomePage extends StatefulWidget {
  const AnimatedHomePage({Key? key}) : super(key: key);

  @override
  State<AnimatedHomePage> createState() => _AnimatedHomePageState();
}

class _AnimatedHomePageState extends State<AnimatedHomePage> with SingleTickerProviderStateMixin{

  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(microseconds: 400),
    );
  }


  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _HomePage(_controller!);
  }
}




class _HomePage extends StatelessWidget {

  late double _deviceHeight;
  late double _deviceWidth;

  Color _primaryColor = Color.fromRGBO(169, 224, 241, 1.0);

  late AnimationController _controller;
  late EnterAnimation _animation;

  _HomePage(this._controller){
    _animation = EnterAnimation(_controller);
    _controller.forward();
  }


  @override
  Widget build(BuildContext context) {

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          height: _deviceHeight * 0.60 ,
          width: _deviceWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _avatarWidget(),
              SizedBox(height: _deviceHeight*  0.03,),
              _nameWidget(),
              SizedBox(height: _deviceHeight* 0.03,),
              _logoutButton(context),
            ],
          ),
        ),
      ),
    );
  }



  Widget _avatarWidget(){
    double _circleD = _deviceHeight * 0.25;

    return AnimatedBuilder(
      animation: _animation.controller,
      builder: (BuildContext _context, Widget? _widget) {
        return Transform (
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(_animation!.circleSize!.value, _animation!.circleSize!.value, 1),
          child: Container(
            height: _circleD,
            width: _circleD,
            decoration: BoxDecoration(
                color: _primaryColor,
                borderRadius: BorderRadius.circular(500),
                image: DecorationImage(
                  image: AssetImage('assets/images/main_avatar.png'),
                )),
          ),
        );
      },
    );
  }

  Widget _nameWidget(){
    return Container(
      child: Text(
        "sh2orc",
        style: TextStyle(
            color: _primaryColor, fontSize: 35, fontWeight: FontWeight.w400),
      ),
    );
  }


  Widget _logoutButton(BuildContext _context){
    return MaterialButton(
      minWidth: _deviceWidth * 0.38,
      height: _deviceHeight * 0.055,
      color: Colors.white,
      child: Text(
        "LOG OUT",
        style: TextStyle(
            fontSize: 16, color: _primaryColor, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(color: _primaryColor, width: 3),
      ),
      onPressed: () async {
        await _controller?.reverse();
        Navigator.pushReplacement(
          _context,
          FadePageRoute(
            AnimatedLoginPage(),
          ),
        );
      },

    );
  }

}
