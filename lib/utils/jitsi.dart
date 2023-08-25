import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

class JitsiMeetMethod{
  bool isAudioMuted = true;
  bool isAudioOnly = false;
  bool isVideoMuted = true;

  createNewMeeting({required String roomName}) async {
    Map<String, Object> featureFlags = {};

    // Define meetings options here
    var options = JitsiMeetingOptions(
      roomNameOrUrl: roomName,
      // serverUrl: serverUrl,
      // subject: subjectText.text,
      // token: tokenText.text,
      isAudioMuted: isAudioMuted,
      isAudioOnly: isAudioOnly,
      isVideoMuted: isVideoMuted,
      userDisplayName: "HOST",
      // userEmail: userEmailText.text,
      featureFlags: featureFlags,
    );
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onConferenceWillJoin: (url) => print("onConferenceWillJoin: url: $url"),
        onConferenceJoined: (url) => print("onConferenceJoined: url: $url"),
        onConferenceTerminated: (url, error) => print("onConferenceTerminated: url: $url, error: $error"),
      ),
    );
  }

  joinMeeting({required String roomName,required String userName}) async {
    Map<String, Object> featureFlags = {
      "unsaferoomwarning.enabled": false
    };

    var options = JitsiMeetingOptions(
      roomNameOrUrl: roomName,
      // serverUrl: serverUrl,
      // subject: subjectText.text,
      // token: tokenText.text,
      isAudioMuted: isAudioMuted,
      isAudioOnly: isAudioOnly,
      isVideoMuted: isVideoMuted,
      userDisplayName: userName,
      // userEmail: userEmailText.text,
      featureFlags: featureFlags,
    );
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onConferenceWillJoin: (url) => print("onConferenceWillJoin: url: $url"),
        onConferenceJoined: (url) => print("onConferenceJoined: url: $url"),
        onConferenceTerminated: (url, error) => print("onConferenceTerminated: url: $url, error: $error"),
      ),
    );
  }
}