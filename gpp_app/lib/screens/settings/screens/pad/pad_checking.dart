import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpp_app/models/json/ppcam_model.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/provider/ppcam_profile.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/screens/settings/screens/pad/custom_pad_menu.dart';
import 'package:gpp_app/screens/settings/screens/pad/custom_snackbar.dart';
import 'package:gpp_app/screens/settings/screens/pad/pad_provider.dart';
import 'package:gpp_app/services/get_ppcam.dart';
import 'package:gpp_app/services/get_video_thumbnail.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/widgets/streaming/custom_vlc_controller.dart';
import 'package:provider/provider.dart';

class PadCheckingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PadCheckingScreenState();
}

class _PadCheckingScreenState extends State<PadCheckingScreen> {
  // For streaming
  PpcamProfile _ppcamProfile;
  bool isPpcamProfileNull;
  Future<PpcamModel> _ppcamModel;
  CustomVlcPlayerController _controller;

  @override
  void initState() {
    _ppcamProfile = Provider.of<PpcamProfile>(context, listen: false);
    MyLogger.debug('$_ppcamProfile');
    // Check ppcam state
    int userId = Provider.of<UserProfile>(context, listen: false).id;
    if (_ppcamProfile.id == null) {
      MyLogger.debug('Ppcam profile is null, so GET ppcam');
      isPpcamProfileNull = true;
      // GET ppcam profile
      _ppcamModel = getPpcam(
        context,
        DioClient.serverUrl + 'user/' + userId.toString() + '/ppcam',
      );
    } else {
      MyLogger.debug('Ppcam profile is not null');
      isPpcamProfileNull = false;
    }
    // Init VLC controller
    _controller = CustomVlcPlayerController(
      onInit: () {
        _controller.play();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get screenSize
    // (long, short) == (width, height)
    double screenWidth = MediaQuery.of(context).size.height; //device height
    // set Landscape orientation at every build time
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    return ChangeNotifierProvider(
      create: (context) => PadProvider(screenWidth: screenWidth),
      child: Builder(
        builder: (context) => isPpcamProfileNull
            // Server request
            ? FutureBuilder(
                future: _ppcamModel,
                builder:
                    (BuildContext context, AsyncSnapshot<PpcamModel> snapshot) {
                  Widget child;
                  // Future complete with data
                  if (snapshot.hasData) {
                    child = _getBody(
                      context,
                      _controller,
                      snapshot.data.ipAddress,
                      snapshot.data.id,
                    );
                    // Future complete with error
                  } else if (snapshot.hasError) {
                    DioError error = snapshot.error;
                    if (error.response != null &&
                        error.response.statusCode == 404) {
                      child = _alertBody(context, '사용하는 푸피캠을 연결해주세요');
                      // Unknown error
                    } else {
                      child = _alertBody(context, '푸피캠 정보를 불러오는 중 오류가 발생했습니다');
                    }
                    // Future incomplete
                  } else {
                    child = Center(child: CircularProgressIndicator());
                  }
                  return child;
                },
              )
            // Already have ppcam profile
            : _getBody(
                context,
                _controller,
                _ppcamProfile.ipAddress,
                _ppcamProfile.id,
              ),
      ),
    );
  }

  @override
  void dispose() {
    // set Landscape orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }
}

Widget _alertBody(BuildContext context, String text) {
  return Scaffold(
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.exit_to_app,
        color: Colors.white,
      ),
      backgroundColor: Colors.orange,
    ),
    body: Center(
      child: Text(text),
    ),
  );
}

Widget _getBody(BuildContext context, CustomVlcPlayerController controller,
    String ppcamUrl, int ppcamId) {
  // ============ FOR TEST ===============
  // ppcamUrl =
  //     'http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_60fps_normal.mp4';
  // ppcamUrl = 'http://beachreachpeach.iptime.org:9981';
  ppcamUrl =
      'https://gpp-images-1.s3.ap-northeast-2.amazonaws.com/gpp_streaming.MOV';
  // ppcamUrl = 'http://172.16.101.111:8090';
  // =====================================
  return Scaffold(
    primary: true,
    floatingActionButton: CustomPadMenu(controller, ppcamId),
    body: SizedBox(
      // width: double.infinity,
      child: Stack(
        children: [
          LiveVideoThumbnail(ppcamUrl),
          // LiveVideo(ppcamUrl, controller),
          Stack(
            children: Provider.of<PadProvider>(context).widgetList,
          ),
          CustomSnackbar(),
        ],
      ),
    ),
  );
}
