import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'trtc_cloud_def.dart';

/// @nodoc
/// channel标识符
String channelType = "trtcCloudChannelView";

/// 视频view窗口,显示本地视频、远端视频或辅流
///
/// 参数：
///
/// onViewCreated: view创建后的回调，生成的当前viewId
///
/// key: Widget key，可以不传
///
/// viewType: 该参数仅对安卓有效，可以不传
///
/// 安卓视频渲染所用的view组件类型，有两个组件可以选择SurfaceView和TextureView。默认为TextureView
///
/// 如果想用TextureView进行渲染，则viewType传TRTCCloudDef.TRTC_VideoView_TextureView
///
/// 如果想用SurfaceView进行渲染，则viewType传TRTCCloudDef.TRTC_VideoView_SurfaceView
class TRTCCloudVideoView extends StatefulWidget {
  final ValueChanged<int>? onViewCreated;
  final int? viewType;
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;
  const TRTCCloudVideoView(
      {Key? key, this.viewType, this.onViewCreated, this.gestureRecognizers})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TRTCCloudVideoViewState(this.viewType);
}

//// @nodoc
class TRTCCloudVideoViewState extends State<TRTCCloudVideoView> {
  TRTCCloudVideoViewState(int? viewType) {
    if (viewType == TRTCCloudDef.TRTC_VideoView_SurfaceView &&
        Platform.isAndroid) {
      channelType = "trtcCloudChannelSurfaceView";
    } else {
      channelType = "trtcCloudChannelView";
    }
  }
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return PlatformViewLink(
        viewType: channelType,
        surfaceFactory: (context,PlatformViewController controller) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: widget.gestureRecognizers??Set.from([]),
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (PlatformViewCreationParams params) {
          return PlatformViewsService.initSurfaceAndroidView(
              id:params.id,
              viewType: params.viewType,
              layoutDirection: TextDirection.ltr,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: (){

              }
          )  ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..addOnPlatformViewCreatedListener(_onPlatformViewCreated)
            ..create();
        },
      );
      // return AndroidView(
      //   viewType: channelType,
      //   onPlatformViewCreated: _onPlatformViewCreated,
      //   gestureRecognizers: widget.gestureRecognizers,
      // );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: channelType,
        onPlatformViewCreated: _onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
      );
    } else {
      return Text("该平台不支持Platform View");
    }
  }

  void _onPlatformViewCreated(int id) {
    widget.onViewCreated!(id);
  }
}

/// @nodoc
/// 视频控制器方法
class TRTCCloudVideoViewController {
  TRTCCloudVideoViewController(int id)
      : _channel = new MethodChannel(channelType + '_$id');

  final MethodChannel _channel;

  /// 开启本地视频的预览画面
  ///
  /// 当开始渲染首帧摄像头画面时，您会收到 TRTCCloudListener 中的 onFirstVideoFrame(null) 回调。
  ///
  /// 参数：
  ///
  /// frontCamera	true：前置摄像头；false：后置摄像头
  Future<void> startLocalPreview(
    bool frontCamera, // true：前置摄像头；false：后置摄像头。
  ) {
    return _channel.invokeMethod('startLocalPreview', {
      "frontCamera": frontCamera,
    });
  }

  /// 更新本地视频预览画面的窗口,仅仅ios有效
  ///
  /// 参数：
  ///
  /// viewId	承载视频画面的控件
  Future<void> updateLocalView(viewId) {
    return _channel.invokeMethod('updateLocalView', {
      "viewId": viewId,
    });
  }

  /// 更新远端视频画面的窗口,仅仅ios有效
  ///
  /// 参数：
  ///
  /// viewId	承载视频画面的控件
  ///
  /// userId 指定远端用户的 userId
  ///
  /// streamType 指定要观看 userId 的视频流类型：
  Future<void> updateRemoteView(viewId, streamType, userId) {
    return _channel.invokeMethod(
      'updateRemoteView',
      {"viewId": viewId, "streamType": streamType, "userId": userId},
    );
  }

  /// 显示远端视频或辅流
  ///
  /// 参数：
  ///
  /// userId 指定远端用户的 userId
  ///
  /// streamType 指定要观看 userId 的视频流类型：
  ///
  ///* 高清大画面：TRTCCloudDef.TRTC_VIDEO_STREAM_TYPE_BIG
  ///
  ///* 低清大画面：TRTCCloudDef.TRTC_VIDEO_STREAM_TYPE_SMALL
  ///
  ///* 辅流（屏幕分享）：TRTCCloudDe.TRTC_VIDEO_STREAM_TYPE_SUB
  Future<void> startRemoteView(
      String userId, // 用户ID
      int streamType) {
    return _channel.invokeMethod(
        'startRemoteView', {"userId": userId, "streamType": streamType});
  }
}
