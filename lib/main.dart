import 'package:flutter/material.dart';


//UI作成課題2！！
//https://dribbble.com/shots/11433513-Sign-In-Sign-Up-Page-App-UI
//https://www.flutter-study.dev/create-ui/sign-in-sign-up

//hide on scroll
//https://medium.com/fabcoding/flutter-hide-show-appbar-while-scrolling-e3c2664b675d

void main()=>runApp(new MyApp());

//Define Colors in App
const Color kAccentColor = Color(0xFFFE7C64);
const Color kBackgroundColor = Color(0xFF19283D);
const Color kTextColorPrimary = Color(0xFFECEFF1);
const Color kTextColorSecondary = Color(0xFFB0BEC5);
const Color kButtonColorPrimary = Color(0xFFECEFF1);
const Color kButtonTextColorPrimary = Color(0xFF455A64);
const Color kIconColor = Color(0xFF455A64);

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'ui_training_2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        accentColor: kAccentColor
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*プラバイダーで囲う*/
    return Scaffold(
      backgroundColor: kBackgroundColor,
        /*　※ボディ＋フッターの上にヘッダーをスタック　*/
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  /*ヘッダー・ボディ・フッターを並べる*/
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: _Body(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: _Footer(),
                  ),
                ],
              ),
            ),
          _Header()
          ],
        ),
    );
  }
}

/*ここからヘッダー*/

//ヘッダー
//背景(クリップする)＋飾りの円＋タイトル＋ボタン…を重ねる！！
class _Header extends StatelessWidget{
  final double height = 320;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Stack(
        children: [
          /*Alignで整頓してstack*/
          Align(
            alignment: Alignment.topCenter,
            child: _HeaderBackground(height: this.height,),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _HeaderCircles(height: this.height,),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _HeaderTitle(height: this.height,),
          ),
          SafeArea(
            child: Positioned(
                top: 16,
                left: 0,
                child: _HeaderBackButton()
            ),
          )
        ],
      ),
    );
  }
}

//ヘッダー背景
class _HeaderBackground extends StatelessWidget{
  final double height;
  const _HeaderBackground({@required this.height}):super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipPath(
      clipper: _HeaderClipper(),
      child: Container(
        height: height,
        width: double.infinity,
        /*グラデーションの追加*/
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              Color(0xFFFD9766),
              Color(0xFFFF7362)
            ],
            stops: [0,1],
          )
        ),
      ),
    );
  }
}

//ヘッダー背景のクリップパスを指定
class _HeaderClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    return Path()
        ..lineTo(0, size.height*0.5)
        ..quadraticBezierTo(size.width*0.55, size.height, size.width, size.height*0.6)
        ..lineTo(size.width, 0)
        ..close();
  }

  /*ここ忘れがち！*/
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

//ヘッダーの飾り部分：円を書く
class _HeaderCircles extends StatelessWidget{
  final double height;
  const _HeaderCircles({@required this.height}):super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      /*カスタムペインターを指定*/
      painter: _HeaderCirclesPainter(),
      child: Container(
        width: double.infinity,
        height: height,
      ),
    );
  }
}

/*カスタムペインターを設定*/
class _HeaderCirclesPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    /*Paint*/
    final paint = Paint()
        ..color = Colors.white.withOpacity(0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6;

    /*Drawを指定*/
    canvas.drawCircle(
        Offset(size.width * 0.25, size.height * 0.4),
        12,
        paint
    );

    canvas.drawCircle(
        Offset(size.width * 0.75, size.height * 0.2),
        12,
        paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

//headerタイトル
class _HeaderTitle extends StatelessWidget{
  final double height;
  const _HeaderTitle({@required this.height}):super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top:128),
      child: Column(
        children: [
          Text(
            'Welcome',
            style: Theme.of(context).textTheme.headline4.copyWith(
              color: kTextColorPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4,),
          Text(
            'Sign in to continue',
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: kTextColorPrimary,
            )
          )
        ],
      ),
    );
  }
}

//戻るボタン
class _HeaderBackButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
      child: Icon(Icons.chevron_left, color: kIconColor,),
      onPressed: (){},
      style: TextButton.styleFrom(
        primary: kButtonTextColorPrimary,
        backgroundColor: Colors.transparent,
        shape: CircleBorder(
          side: BorderSide(color: kButtonColorPrimary),
        ),
      ),
    );
  }
}

/*ここまでヘッダー*/

/*ここからボディ・フォーム*/
class _Body extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        SizedBox(height: 300,),
        _TextForm(
            labelText: 'Email',
            hintText: 'your email address goes here',
            obscureText: false
        ),
        SizedBox(height: 40,),
        _TextForm(
            labelText: 'Password',
            hintText: 'your password goes here',
            obscureText: true
        ),
        SizedBox(height: 10,),
        GestureDetector(
            onTap: (){},
            child: Text(
              'Forgot Password?',
              style: Theme.of(context).textTheme.bodyText2.copyWith(color: kTextColorSecondary),
            )
        ),
        SizedBox(height: 35,),
        Container(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              primary: kButtonTextColorPrimary,
              backgroundColor: kButtonColorPrimary,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Sign in',
              style: Theme.of(context).textTheme.button.copyWith(color: kButtonTextColorPrimary, fontSize: 18),
            ),
            onPressed: (){},
          ),
        ),
        SizedBox(height: 16,),
        Text(
          'OR',
          style: Theme.of(context).textTheme.bodyText2.copyWith(color: kTextColorSecondary),
        ),
        SizedBox(height: 16,),
        Text(
          'Connect With',
          style: Theme.of(context).textTheme.bodyText2.copyWith(color: kTextColorPrimary),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(icon: Icon(Icons.account_circle), onPressed: (){}),
            Container(
              color: kTextColorSecondary,
              width: 1,
              height: 16,
            ),
            IconButton(icon: Icon(Icons.account_circle), onPressed: (){}),
          ],
        )

      ],
    );

  }
}

/*入力フォーム部*/
class _TextForm extends StatelessWidget{
  final String labelText;
  final String hintText;
  final bool obscureText;

  const _TextForm({
    @required this.labelText,
    @required this.hintText,
    @required this.obscureText
  }):super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: kTextColorSecondary,),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: kAccentColor)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:BorderRadius.circular(8),
                borderSide: BorderSide(color: kTextColorSecondary)
              )
            ),
            obscureText: obscureText,
            onChanged: (value){},
          ),
        ),
        Container(
            alignment: Alignment.topCenter,
            width: 70,
            color: kBackgroundColor,
            child: Text(
              labelText,
              style: TextStyle(color: kTextColorSecondary),
            )
        )
      ]
    );
  }
}

/*ここまでボディ*/


/*ここからフッター*/
class _Footer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have Account?',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: kTextColorSecondary),
        ),
        SizedBox(width: 4),
        GestureDetector(
          onTap: (){},
          child: Text(
            'Sign up',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: kTextColorPrimary),
          ),
        ),
      ],
    );
  }
}

/*ここまでフッター*/

