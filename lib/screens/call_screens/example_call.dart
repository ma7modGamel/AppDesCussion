import 'dart:developer';
import 'package:discussion/provider/profile_provider.dart';
import 'package:discussion/screens/packages_screens/packages_screen.dart';
import 'package:discussion/services/api_services/package_helper.dart';
import 'package:discussion/services/api_services/profile_helper.dart';
import 'package:discussion/tools/app_components.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class ExampleCall extends StatefulWidget {
  ExampleCall({Key key,this.parentContext, this.title,this.channelId,this.token,this.appId,this.uid,this.topic,this.alwaysOpen,this.callId}) : super(key: key);

  final String title;
  final String channelId;
  final String token;
  final String appId;
  final int uid;
  final int topic;
  final bool alwaysOpen;
  final String callId;
  final parentContext;

  @override
  _ExampleCallState createState() => _ExampleCallState();
}

class _ExampleCallState extends State<ExampleCall> {

  RtcEngine _engine = null;
  var _playerTxt="";
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;
  var status="noCaller".tr();
  bool _enableInEarMonitoring = false;
  double _recordingVolume = 0, _playbackVolume = 0, _inEarMonitoringVolume = 0;
  TextEditingController _controller;
  var user;
  StopWatchTimer stopWatchTimer;
  var currentIserId;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.channelId);
    this._initEngine();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false).currentIserId=null;
    });

  }

  @override
  void dispose() {
    super.dispose();
    try {
      _engine?.destroy();
      if (stopWatchTimer != null) {
        stopWatchTimer.dispose();
      }
    }catch(e){

    }

    print("ttttttt");
    //showLikeDialog();
    if(currentIserId != null){
      PackageHelper.endCall(widget.channelId, _playerTxt);
    }
  }

  _initEngine() async {
    _engine =
    await RtcEngine.create(widget.appId);
    this._addListeners();

    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    _joinChannel();
  }

  _addListeners() {
    _engine?.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        if(uid.toString() != widget.uid.toString()){
          setState(() {
            //isJoined = false;
           // status="يوجد متصل رقمه $uid";
          });
        }
      },
      userJoined: (uid, elapsed)async {
        isJoined = true;
        currentIserId=uid;
        print('userJoined ${elapsed} ${uid} ${elapsed}');
        if(uid.toString() != widget.uid.toString()){
          user=(await ProfileHelper.getUserData(uid))['data'];
          stopWatchTimer=StopWatchTimer(
            mode: StopWatchMode.countUp,
            onChange: (value) {
              _playerTxt = StopWatchTimer.getDisplayTime(value);
              print('displayTime $_playerTxt');
              if(!widget.alwaysOpen && StopWatchTimer.getRawMinute(value)>15){
                Navigator.pop(context);
              }
              setState(() {

              });
            },
            onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
            onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
          );
          stopWatchTimer.rawTime.listen((value) =>
              print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
          stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
          stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
          stopWatchTimer.records.listen((value) => print('records $value'));
          stopWatchTimer.onExecute.add(StopWatchExecute.start);
          Provider.of<ProfileProvider>(context, listen: false).currentIserId=uid.toString();
          setState(()  {
            isJoined = true;
            currentIserId=uid;
            status="يوجد متصل رقمه $uid";
          });
        }},
      userOffline: (uid, reason) {
        log('userOffline ${uid} ${uid} ${reason}');
        setState(() {
          isJoined = false;
          status="noCaller".tr();
        });
        },
      leaveChannel: (stats) async {
        log('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
        await _engine
            ?.joinChannel(widget.token, widget.channelId, null, widget.uid)
            ?.catchError((err) {
          print('error ${err.toString()}');
        });
      },
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    await _engine
        ?.joinChannel(widget.token, widget.channelId, null, widget.uid)
        ?.catchError((onError) {
      print('error ${onError.toString()}');
    });
  }

  _leaveChannel() async {
    await _engine?.leaveChannel();
  }

  _switchMicrophone() {
    _engine?.enableLocalAudio(!openMicrophone)?.then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    })?.catchError((err) {
      print('enableLocalAudio $err');
    });
  }

  _switchSpeakerphone() {
    _engine?.setEnableSpeakerphone(!enableSpeakerphone)?.then((value) {
      setState(() {
        enableSpeakerphone = !enableSpeakerphone;
      });
    })?.catchError((err) {
      print('setEnableSpeakerphone $err');
    });
  }

  _switchEffect() async {
    if (playEffect) {
      _engine?.stopEffect(1)?.then((value) {
        setState(() {
          playEffect = false;
        });
      })?.catchError((err) {
        print('stopEffect $err');
      });
    } else {
      _engine
          ?.playEffect(
          1,
         /* await RtcEngineExtension.getAssetAbsolutePath(
              "assets/Sound_Horizon.mp3"),*/null,
          -1,
          1,
          1,
          100,
          true)
          ?.then((value) {
        setState(() {
          playEffect = true;
        });
      })?.catchError((err) {
        print('playEffect $err');
      });
    }
  }

  _onChangeInEarMonitoringVolume(double value) {
    setState(() {
      _inEarMonitoringVolume = value;
    });
    _engine?.setInEarMonitoringVolume(value.toInt());
  }

  _toggleInEarMonitoring(value) {
    setState(() {
      _enableInEarMonitoring = value;
    });
    _engine?.enableInEarMonitoring(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text(""),
        backgroundColor: mainColor.withOpacity(.5),
      ),*/
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [

           user != null? Align(

              child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(image:
                  user == null || user['image']==null?AssetImage(user == null || user['gender_id']==1?"assets/images/boy.png":"assets/images/girl.png"):NetworkImage("${user['image'].toString()}")
                      ,fit: BoxFit.cover),
                gradient: LinearGradient(
                  colors: [Color(0xEEFFFFFF), Color(0xCCFFFFFF)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white.withOpacity(.7),
                )
          ),
          ):Container(),


            Align(
                alignment: Alignment.center,
                child: Container(
                  color:isJoined? Colors.transparent:Colors.transparent,
                  //height: 50.0,
                  padding:
                  EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                  child: isJoined?Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 0),
                          height: 106,width: 106,
                          alignment: Alignment.topRight,
                          decoration: BoxDecoration(

                              image: DecorationImage(image:
                              user['image']==null?AssetImage(user['gender_id']==1?"assets/images/boy.png":"assets/images/girl.png"):NetworkImage("${user['image'].toString()}")
                                  ,fit: BoxFit.fill),
                              borderRadius: BorderRadius.all(Radius.circular(53)),
                              border: Border.all(color: Colors.white,width: 4),
                              boxShadow: [
                                BoxShadow(color: Color(0xff00000029),blurRadius: 6,offset: Offset(0, 6)),
                                BoxShadow(color: Color(0xff00000029),blurRadius: 6,offset: Offset(0, 6)),
                                BoxShadow(color: Color(0xff00000029),blurRadius: 6,offset: Offset(0, 6)),
                                BoxShadow(color: Color(0xff00000029),blurRadius: 6,offset: Offset(0, 6))
                              ]

                          ),

                        ),
                        onTap: (){
                          showUserPopUp(context,user);
                        },
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(user['name'],textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 20,fontFamily: mainFont
                        ),),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(_playerTxt.substring(0,8),textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 20,fontFamily: mainFont
                        ),),
                      ),

                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [


                            InkWell(
                              child: Container(
                                child: Icon(
                                  openMicrophone?Icons.volume_up:Icons.volume_off,
                                  color: mainColor,
                                  size: 40,
                                ),
                              ),
                              onTap: () {
                                _switchMicrophone();
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              child: Container(
                                child: Icon(
                                  enableSpeakerphone ? Icons.mic : Icons.mic_off,
                                  color: mainColor,
                                  size: 40,
                                ),
                              ),
                              onTap: () {
                                _switchSpeakerphone();
                              },
                            ),

                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),

                          ],
                        ),
                      )

                    ],
                  ):Center(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        AppLoading(),
                        Container(
                          child: Text(status,textAlign: TextAlign.center,style: TextStyle(
                              fontSize: 20,fontFamily: mainFont
                          ),),
                        ),

                      ],
                    )
                  )
                )
            )
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // We want to round up the remaining time to the nearest second
    d += Duration(microseconds: 999999);
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
  }



  @override
  void didChangeDependencies() {
    print("fffffffffffffff");
  }




}
