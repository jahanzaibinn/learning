import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:flutter/material.dart';

class Call extends StatefulWidget {
  const Call({super.key});

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  late final ApiVideoLiveStreamController _controller ;

  @override
  void initState() {
    // TODO: implement initState
    initializer();
    super.initState();
  }

  initializer() async {
    setState(() {
      _controller =  ApiVideoLiveStreamController(
          initialAudioConfig: AudioConfig(),
          initialVideoConfig: VideoConfig.withDefaultBitrate());
    });
    await _controller.initialize();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _controller.stop();
    } else if (state == AppLifecycleState.resumed) {
      _controller.startPreview();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  _controller.startStreaming(
                      streamKey: 'KRLpMsmlT9mtN2hjopkEIyJgw1rPyzizQ696SsNFJkR',url: "https://sandbox.api.video/auth/api-key");
                },
                child: Text('start stream')),
            TextButton(
                onPressed: () {
                  _controller.stop();
                },
                child: Text('stop stream'))
          ],
        ),
        Expanded(
          child: ApiVideoCameraPreview(controller: _controller),
        )
      ],
    );
  }
}
