//import 'package:flutter/foundation.dart';
//import 'package:http/http.dart' as http; //IMPORT HTTP LIBRARY
//import 'dart:convert';
//
////CLASS INI UNTUK MENDEFINISIKAN SEPERTI APA FORMAT DATA YANG DIINGINKAN
//class VideoModel {
//  //DEFINISIKAN VARIABLE APA SAJA YANG DIBUTUHKAN
//  final String videoId;
//  final String title;
//  final String channelId;
//  final String channelTitle;
//  final String image;
//
//  //BUAT CONSTRUCTOR, AGAR KETIKA CLASS INI DIGUNAKAN MAKA WAJIB MENGIRIMKAN DATA YANG DIMINTA DI CONSTRUCTOR
//  VideoModel({
//    @required this.videoId,
//    @required this.title,
//    @required this.channelId,
//    @required this.channelTitle,
//    @required this.image,
//  });
//
//  //FORMATTING DATA MENJADI FORMAT YANG DIINGINKAN
//  //MENGGUNAKAN METHOD fromJson, DIMANA EXPECT DATANYA ADALAH MAP DENGAN KEY STRING DAN VALUE DYNAMIC
//  factory VideoModel.fromJson(Map<String, dynamic> json) {
//    //UBAH FORMAT DATANYA SESUAI FORMAT YANG DIMINTA PADA CONSTRUCTOR
//    return VideoModel(
//      videoId: json['id']['videoId'],
//      title: json['snippet']['title'],
//      channelId: json['snippet']['channelId'],
//      channelTitle: json['snippet']['channelTitle'],
//      image: json['snippet']['thumbnails']['high']['url'],
//    );
//  }
//}
//
////CLASS INI SEBAGAI STATE MANAGEMENT
//class VideoProvider with ChangeNotifier {
//  List<VideoModel> _items = []; //DEFINISIKAN VARIABLE UNTUK MENAMPUNG DATA VIDEO
//
//  //KARENA VARIABLE DIATAS ADA PRIVATE, MAKA KITA BUAT GETTER AGAR DAPAT DIAKSES DARI LUAR CLASS INI
//  List<VideoModel> get items {
//    return _items;
//  }
//
//  //BUAT FUNGSI UNTUK MENGAMBIL DATA DARI API YOUTUBE
//  Future<void> getVideo(String requestKeyword) async {
//    final keyword = 'ustadz ' + requestKeyword; //DIMANA KEYWORDNYA MENGGUNAKAN PREFIX USTADZ SEHINGGA HANYA AKAN MENGAMBIL DATA YANG TERKAIT DENGAN USTADZ
//    final apiToken = 'API TOKEN ANDA'; //MASUKKAN API TOKEN YANG KAMU DAPATKAN DARI PROSES SEBELUMNYA
//
//    //ENDPOINT API YOUTUBE UNTUK MENGAMBIL VIDEO-NYA BERDASARKAN PENCARIAN DAN EVENTYPE = LIVE
//    final url =
//        'https://www.googleapis.com/youtube/v3/search?part=snippet&eventType=live&relevanceLanguage=id&maxResults=25&q=$keyword&type=video&key=$apiToken';
//    final response = await http.get(url); //KIRIM REQUEST
//    final extractData = json.decode(response.body)['items']; //DECODE JSON YANG DITERIMA
//
//    //JIKA DIA NULL, MAKA HENTIKAN PROSESNYA
//    if (extractData == null) {
//      return;
//    }
//
//    //JIKA TIDAK MAKA ASSIGN DATA NYA KE DALAM VARIABLE _items
//    //DENGAN FORMAT DATA MENGGUNAKAN fromJson()
//    _items =
//        extractData.map<VideoModel>((i) => VideoModel.fromJson(i)).toList();
//    notifyListeners(); //INFORMASIKAN JIKA TERJADI PERUBAHAN DATA
//  }
//
//  //METHOD UNTUK MENGAMBIL DATA VIDEO BERDASARKAN VIDEOID, METHOD INI DIGUNAKAN PADA SCREEN DETAIL NANTINYA
//  VideoModel findVideo(String videoId) {
//    return _items.firstWhere((q) => q.videoId == videoId);
//  }
//}
//
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/old_ver.services.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
//import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
//import 'package:soedja_freelance/revamp/modules/feeds/old_ver.models/feeds_model.dart';
//import 'package:soedja_freelance/revamp/old_ver.themes/colors.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
//class DetailPortfolioScreen extends StatefulWidget {
//  final Feed portfolio;
//  final AuthBloc authBloc;
//
//  const DetailPortfolioScreen({Key key, this.portfolio, this.authBloc})
//      : super(key: key);
//
//  @override
//  State<StatefulWidget> createState() {
//    return _DetailPortfolioScreen();
//  }
//}
//
//class _DetailPortfolioScreen extends State<DetailPortfolioScreen> {
//  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//  YoutubePlayerController _controller;
//  TextEditingController _idController;
//  TextEditingController _seekToController;
//
//  PlayerState _playerState;
//  YoutubeMetaData _videoMetaData;
//  double _volume = 100;
//  bool _muted = false;
//  bool _isPlayerReady = false;
//
//  final List<String> _ids = [
//    'nPt8bK2gbaU',
//    'gQDByCdjUXw',
//    'iLnmTe5Q2Qw',
//    '_WoCV4c6XOE',
//    'KmzdUe0RSJo',
//    '6jZDSSZZxjQ',
//    'p2lYr3vM_1w',
//    '7QUtEmBT_-w',
//    '34_PXCzGw1M',
//  ];
//
//  @override
//  void initState() {
//    super.initState();
//    _controller = YoutubePlayerController(
//      initialVideoId: _ids.first,
//      flags: const YoutubePlayerFlags(
//        mute: false,
//        autoPlay: true,
//        disableDragSeek: false,
//        loop: false,
//        isLive: false,
//        forceHD: false,
//        enableCaption: true,
//      ),
//    )..addListener(listener);
//    _idController = TextEditingController(text: "https://www.youtube.com/watch?v=zmKMJ8IhSQs");
//    _seekToController = TextEditingController();
//    _videoMetaData = const YoutubeMetaData();
//    _playerState = PlayerState.unknown;
//  }
//
//  void listener() {
//    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
//      setState(() {
//        _playerState = _controller.value.playerState;
//        _videoMetaData = _controller.metadata;
//      });
//    }
//  }
//
//  @override
//  void deactivate() {
//    // Pauses video while navigating to next page.
//    _controller.pause();
//    super.deactivate();
//  }
//
//  @override
//  void dispose() {
//    _controller.dispose();
//    _idController.dispose();
//    _seekToController.dispose();
//    super.dispose();
//  }
//  @override
//  Widget build(BuildContext context) {
//    return YoutubePlayerBuilder(
//      onExitFullScreen: () {
//        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
//        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//      },
//      player: YoutubePlayer(
//        controller: _controller,
//        showVideoProgressIndicator: true,
//        progressIndicatorColor: ColorApps.primary,
//        topActions: <Widget>[
//          const SizedBox(width: 8.0),
//          Expanded(
//            child: Text(
//              _controller.metadata.title,
//              style: const TextStyle(
//                color: Colors.white,
//                fontSize: 18.0,
//              ),
//              overflow: TextOverflow.ellipsis,
//              maxLines: 1,
//            ),
//          ),
////          IconButton(
////            icon: const Icon(
////              Icons.settings,
////              color: Colors.white,
////              size: 25.0,
////            ),
////            onPressed: () {
////              print("Settings Tapped!");
////            },
////          ),
//        ],
//        onReady: () {
//          _isPlayerReady = true;
//        },
//        onEnded: (data) {
//          _controller
//              .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
//          _showSnackBar('Next Video Started!');
//        },
//      ),
//      builder: (context, player) => Scaffold(
//        key: _scaffoldKey,
//        appBar: AppBar(
//          leading: Padding(
//            padding: const EdgeInsets.only(left: 12.0),
//            child: Image.asset(
//              'assets/ypf.png',
//              fit: BoxFit.fitWidth,
//            ),
//          ),
//          title: const Text(
//            'Youtube Player Flutter',
//            style: TextStyle(color: Colors.white),
//          ),
//          actions: [
////            IconButton(
////              icon: const Icon(Icons.video_library),
////              onPressed: () => Navigator.push(
////                context,
////                CupertinoPageRoute(
////                  builder: (context) => VideoList(),
////                ),
////              ),
////            ),
//          ],
//        ),
//        body: ListView(
//          children: [
//            player,
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                children: [
//                  _space,
//                  _text('Title', _videoMetaData.title),
//                  _space,
//                  _text('Channel', _videoMetaData.author),
//                  _space,
//                  _text('Video Id', _videoMetaData.videoId),
//                  _space,
//                  Row(
//                    children: [
//                      _text(
//                        'Playback Quality',
//                        _controller.value.playbackQuality,
//                      ),
//                      const Spacer(),
//                      _text(
//                        'Playback Rate',
//                        '${_controller.value.playbackRate}x  ',
//                      ),
//                    ],
//                  ),
//                  _space,
//                  TextField(
//                    enabled: _isPlayerReady,
//                    controller: _idController,
//                    decoration: InputDecoration(
//                      border: InputBorder.none,
//                      hintText: 'Enter youtube \<video id\> or \<link\>',
//                      fillColor: Colors.blueAccent.withAlpha(20),
//                      filled: true,
//                      hintStyle: const TextStyle(
//                        fontWeight: FontWeight.w300,
//                        color: Colors.blueAccent,
//                      ),
//                      suffixIcon: IconButton(
//                        icon: const Icon(Icons.clear),
//                        onPressed: () => _idController.clear(),
//                      ),
//                    ),
//                  ),
//                  _space,
//                  Row(
//                    children: [
//                      _loadCueButton('LOAD'),
//                      const SizedBox(width: 10.0),
//                      _loadCueButton('CUE'),
//                    ],
//                  ),
//                  _space,
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: [
//                      IconButton(
//                        icon: const Icon(Icons.skip_previous),
//                        onPressed: _isPlayerReady
//                            ? () => _controller.load(_ids[
//                        (_ids.indexOf(_controller.metadata.videoId) -
//                            1) %
//                            _ids.length])
//                            : null,
//                      ),
//                      IconButton(
//                        icon: Icon(
//                          _controller.value.isPlaying
//                              ? Icons.pause
//                              : Icons.play_arrow,
//                        ),
//                        onPressed: _isPlayerReady
//                            ? () {
//                          _controller.value.isPlaying
//                              ? _controller.pause()
//                              : _controller.play();
//                          setState(() {});
//                        }
//                            : null,
//                      ),
//                      IconButton(
//                        icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
//                        onPressed: _isPlayerReady
//                            ? () {
//                          _muted
//                              ? _controller.unMute()
//                              : _controller.mute();
//                          setState(() {
//                            _muted = !_muted;
//                          });
//                        }
//                            : null,
//                      ),
//                      FullScreenButton(
//                        controller: _controller,
//                        color: Colors.blueAccent,
//                      ),
//                      IconButton(
//                        icon: const Icon(Icons.skip_next),
//                        onPressed: _isPlayerReady
//                            ? () => _controller.load(_ids[
//                        (_ids.indexOf(_controller.metadata.videoId) +
//                            1) %
//                            _ids.length])
//                            : null,
//                      ),
//                    ],
//                  ),
//                  _space,
//                  Row(
//                    children: <Widget>[
//                      const Text(
//                        "Volume",
//                        style: TextStyle(fontWeight: FontWeight.w300),
//                      ),
//                      Expanded(
//                        child: Slider(
//                          inactiveColor: Colors.transparent,
//                          value: _volume,
//                          min: 0.0,
//                          max: 100.0,
//                          divisions: 10,
//                          label: '${(_volume).round()}',
//                          onChanged: _isPlayerReady
//                              ? (value) {
//                            setState(() {
//                              _volume = value;
//                            });
//                            _controller.setVolume(_volume.round());
//                          }
//                              : null,
//                        ),
//                      ),
//                    ],
//                  ),
//                  _space,
//                  AnimatedContainer(
//                    duration: const Duration(milliseconds: 800),
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(20.0),
//                      color: _getStateColor(_playerState),
//                    ),
//                    padding: const EdgeInsets.all(8.0),
//                    child: Text(
//                      _playerState.toString(),
//                      style: const TextStyle(
//                        fontWeight: FontWeight.w300,
//                        color: Colors.white,
//                      ),
//                      textAlign: TextAlign.center,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _text(String title, String value) {
//    return RichText(
//      text: TextSpan(
//        text: '$title : ',
//        style: const TextStyle(
//          color: Colors.blueAccent,
//          fontWeight: FontWeight.bold,
//        ),
//        children: [
//          TextSpan(
//            text: value ?? '',
//            style: const TextStyle(
//              color: Colors.blueAccent,
//              fontWeight: FontWeight.w300,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Color _getStateColor(PlayerState state) {
//    switch (state) {
//      case PlayerState.unknown:
//        return Colors.grey[700];
//      case PlayerState.unStarted:
//        return Colors.pink;
//      case PlayerState.ended:
//        return Colors.red;
//      case PlayerState.playing:
//        return Colors.blueAccent;
//      case PlayerState.paused:
//        return Colors.orange;
//      case PlayerState.buffering:
//        return Colors.yellow;
//      case PlayerState.cued:
//        return Colors.blue[900];
//      default:
//        return Colors.blue;
//    }
//  }
//
//  Widget get _space => const SizedBox(height: 10);
//
//  Widget _loadCueButton(String action) {
//    return Expanded(
//      child: MaterialButton(
//        color: Colors.blueAccent,
//        onPressed: _isPlayerReady
//            ? () {
//          if (_idController.text.isNotEmpty) {
//            var id = YoutubePlayer.convertUrlToId(
//              _idController.text,
//            );
//            if (action == 'LOAD') _controller.load(id);
//            if (action == 'CUE') _controller.cue(id);
//            FocusScope.of(context).requestFocus(FocusNode());
//          } else {
//            _showSnackBar('Source can\'t be empty!');
//          }
//        }
//            : null,
//        disabledColor: Colors.grey,
//        disabledTextColor: Colors.black,
//        child: Padding(
//          padding: const EdgeInsets.symmetric(vertical: 14.0),
//          child: Text(
//            action,
//            style: const TextStyle(
//              fontSize: 18.0,
//              color: Colors.white,
//              fontWeight: FontWeight.w300,
//            ),
//            textAlign: TextAlign.center,
//          ),
//        ),
//      ),
//    );
//  }
//
//  void _showSnackBar(String message) {
//    _scaffoldKey.currentState.showSnackBar(
//      SnackBar(
//        content: Text(
//          message,
//          textAlign: TextAlign.center,
//          style: const TextStyle(
//            fontWeight: FontWeight.w300,
//            fontSize: 16.0,
//          ),
//        ),
//        backgroundColor: Colors.blueAccent,
//        behavior: SnackBarBehavior.floating,
//        elevation: 1.0,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(50.0),
//        ),
//      ),
//    );
//  }
//}

//  @override
//  Widget build(BuildContext context) {
//    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
//    Size size = MediaQuery.of(context).size;
//
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.white,
//        leading: IconButton(
//            icon: Icon(
//              Icons.arrow_back_ios,
//              color: Colors.black,
//            ),
//            onPressed: () => Navigation().navigateBack(context)),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.share),
//            onPressed: () {},
//          ),
//          IconButton(
//            icon: Icon(Icons.bookmark_border),
//            onPressed: () {},
//          ),
//          SizedBox(
//            width: ScreenUtil().setWidth(10),
//          ),
//        ],
//      ),
//      body: Stack(
//        children: <Widget>[
//          Positioned.fill(
//            child: ListView(
//              children: <Widget>[],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
