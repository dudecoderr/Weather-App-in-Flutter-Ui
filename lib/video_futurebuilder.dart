import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class Home1Page extends StatefulWidget {
  const Home1Page({Key? key}) : super(key: key);

  @override
  State<Home1Page> createState() => _Home1PageState();
}

class _Home1PageState extends State<Home1Page> {
  bool val = false;

  ///====== video controller =============
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  String videoUrl =
      "https://player.vimeo.com/progressive_redirect/playback/800983016/rendition/720p/file.mp4?loc=external&oauth2_token_id=57447761&signature=5e95c9c81482702e3ef754f98add5da27f2833eaca546d736ed6a00427a83fc4";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setVolume(val ? 0.0 : 0.0);
    _controller.setLooping(val ? true : true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateVideoUrl() {
    setState(() {
      videoUrl = val
          ? "https://player.vimeo.com/progressive_redirect/playback/693779671/rendition/720p?loc=external&oauth2_token_id=57447761&signature=7c506d63f5a95c638165173bd579e0829ee7ef15840c489cedc7dfc2a8ad37f4"
          : "https://player.vimeo.com/progressive_redirect/playback/800983016/rendition/720p/file.mp4?loc=external&oauth2_token_id=57447761&signature=5e95c9c81482702e3ef754f98add5da27f2833eaca546d736ed6a00427a83fc4";
      _controller = VideoPlayerController.network(videoUrl);
      _initializeVideoPlayerFuture = _controller.initialize();
      _controller.setVolume(val ? 0.0 : 0.0);
      _controller.setLooping(val ? true : true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          /* Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : SizedBox(),
          ),
*/
          ///_____________ appbar _________________
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45, right: 20, left: 20),
                child: Row(
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: const BoxDecoration(
                          color: Colors.black54, shape: BoxShape.circle),
                      child: const Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: const BoxDecoration(
                          color: Colors.black54, shape: BoxShape.circle),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: 25.h,
                        width: 74.w,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: DayNightSwitch(
                            value: val,
                            onChanged: (value) {
                              setState(() {
                                val = value;
                                _updateVideoUrl();
                              });
                              /*setState(() {
                                val = value;
                                videoUrl = val
                                    ? "https://player.vimeo.com/progressive_redirect/playback/693779671/rendition/720p?loc=external&oauth2_token_id=57447761&signature=7c506d63f5a95c638165173bd579e0829ee7ef15840c489cedc7dfc2a8ad37f4"
                                    : "https://player.vimeo.com/progressive_redirect/playback/800983016/rendition/720p/file.mp4?loc=external&oauth2_token_id=57447761&signature=5e95c9c81482702e3ef754f98add5da27f2833eaca546d736ed6a00427a83fc4"; //1st video
                                _controller.dispose();
                                _controller =
                                    VideoPlayerController.network(videoUrl);
                                _controller.initialize().then((_) {
                                  setState(() {});
                                  _controller.play();
                                  _controller.setVolume(val ? 0.0 : 0.0);
                                  _controller.setLooping(val ? true : true);
                                });
                              });*/
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 55.h),
              val
                  ? Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Container(
                        height: 45.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 30.h,
                              width: 30.h,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                "Don't forget your ☂☂☂ shower are coming...",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),

              ///________________  Berlin text  _______________
              SizedBox(height: val ? 150.h : 195.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Berlin",
                  style: TextStyle(
                      color: val ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.sp),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  val ? "Showers" : "Mostly sunny",
                  style: TextStyle(
                      color: val ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  child: Text(
                    val ? "17°" : "26°",
                    style: TextStyle(
                        color: val ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 95.sp),
                  ),
                ),
              ),
            ],
          ),

          ///________________ image container _________________

          Padding(
            padding:
                const EdgeInsets.only(right: 15, left: 15, bottom: 40, top: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120.h,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25.r)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //____________________ 1 _________________________
                        Column(
                          children: [
                            Text(
                              "Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10.h),
                            Image.asset(
                              "assets/summer_sun.gif",
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "27°",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        //_________________2____________________
                        Column(
                          children: [
                            Text(
                              "14:00",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10.h),
                            Image.asset(
                              "assets/rain_sun.gif",
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "25°",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        //__________ 3____________________
                        Column(
                          children: [
                            Text(
                              "15:00",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10.h),
                            Image.asset(
                              "assets/summer_sun.gif",
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "24°",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        //_________________ 4 ____________________
                        Column(
                          children: [
                            Text(
                              "16:00",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10.h),
                            Image.asset(
                              "assets/rain_sun.gif",
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "23°",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        //___________________ 5 _____________
                        Column(
                          children: [
                            Text(
                              "17:00",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10.h),
                            Image.asset(
                              "assets/weather_sky.gif",
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "21°",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
