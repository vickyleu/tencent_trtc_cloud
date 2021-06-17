## 腾讯 tencent_trtc_cloud

[English document](https://intl.cloud.tencent.com/document/product/647/39243?lang=en&pg=) [英語の文書](https://intl.cloud.tencent.com/jp/document/product/647/39243?lang=jp&pg=)

该flutter sdk是基于 腾讯云 iOS/Android 平台的 SDK进行封装。

[API 概览](https://cloud.tencent.com/document/product/647/51530)

[API 详细文档](https://pub.dev/documentation/tencent_trtc_cloud/latest/index.html)

多人视频会议DEMO地址 [Github](https://github.com/c1avie/trtc_demo)。

一对一音视频通话、语音沙龙DEMO地址 [Github](https://github.com/tencentyun/TRTCFlutterScenesDemo)。

任何问题可以通过 Github Issues 提问，也可加qq群788910197咨询。

注意：demo不支持模拟机运行，请使用真机开发调试。

#### 快速跑通Demo

详情参考[跑通Demo(Flutter)](https://cloud.tencent.com/document/product/647/51601)

#### 快速集成SDK

详情参考[快速集成(Flutter)](https://cloud.tencent.com/document/product/647/51602)

#### sdk类文件说明

* trtc_cloud-腾讯云视频通话功能的主要接口类
* trtc_cloud_video_view-提供渲染视频TRTCCloudVideoView的widget
* tx_audio_effect_manager-腾讯云视频通话功能音乐和人声设置接口
* tx_beauty_manager-美颜及动效参数管理
* tx_device_manager-设备管理类
* trtc_cloud_def-腾讯云视频通话功能的关键类型定义
* trtc_cloud_listener-腾讯云视频通话功能的事件回调监听接口

#### 调用示例

1.初始化
```
// 创建 TRTCCloud 单例
trtcCloud = await TRTCCloud.sharedInstance();
// 获取设备管理模块
txDeviceManager = trtcCloud.getDeviceManager();
// 获取美颜管理对象
txBeautyManager = trtcCloud.getBeautyManager();
// 获取音效管理类
txAudioManager = trtcCloud.getAudioEffectManager();
```

2.进退房
```
//进房
trtcCloud.enterRoom(
        TRTCParams(
            sdkAppId: sdkAppId, //应用Id
            userId: userId, // 用户Id
            userSig: userSig, // 用户签名
            roomId: roomId), //房间Id
        TRTCCloudDef.TRTC_APP_SCENE_VIDEOCALL);
//退房
trtcCloud.exitRoom();
```

3.事件监听
```
//设置事件监听
trtcCloud.registerListener(onRtcListener);
onRtcListener(type, param) {
  //进房回调事件
  if (type == TRTCCloudListener.onEnterRoom) {
    if (param > 0) {
      showToast('进房成功');
    }
  }
  // 远端用户进房
  if (type == TRTCCloudListener.onRemoteUserEnterRoom) {
    //param参数为远端用户userId
  }
  //远端用户是否存在可播放的主路画面（一般用于摄像头）
  if (type == TRTCCloudListener.onUserVideoAvailable) {
    //param['userId']表示远端用户id
    //param['visible']画面是否开启
  }
}
//移除事件监听
trtcCloud.unRegisterListener(onRtcListener);
```

4.显示本地视频
```
// 参数：
// frontCamera	true：前置摄像头；false：后置摄像头
// viewId TRTCCloudVideoView生成的viewId
TRTCCloudVideoView(
    onViewCreated: (viewId) {
      trtcCloud.startLocalPreview(true, viewId);
});
```

5.显示远端视频

```
// 参数：
// userId 指定远端用户的 userId
// streamType 指定要观看 userId 的视频流类型：
//* 高清大画面：TRTCCloudDef.TRTC_VIDEO_STREAM_TYPE_BIG
//* 低清大画面：TRTCCloudDef.TRTC_VIDEO_STREAM_TYPE_SMALL
// viewId TRTCCloudVideoView生成的viewId
TRTCCloudVideoView(
    onViewCreated: (viewId) {
      trtcCloud.startRemoteView(userId, TRTCCloudDef.TRTC_VIDEO_STREAM_TYPE_SMALL, viewId);
});
```

5.显示远端屏幕分享

```
/// 参数：
/// userId 指定远端用户的 userId
/// streamType 指定要观看 userId 的视频流类型：
///* 辅流（屏幕分享）：TRTCCloudDe.TRTC_VIDEO_STREAM_TYPE_SUB
/// viewId TRTCCloudVideoView生成的viewId
TRTCCloudVideoView(
    onViewCreated: (viewId) {
      trtcCloud.startRemoteView(userId, TRTCCloudDef.TRTC_VIDEO_STREAM_TYPE_SUB, viewId);
});
```

#### 如何查看 TRTC 日志？
TRTC 的日志默认压缩加密，后缀为 .xlog。
* iOS：sandbox的Documents/log
* Android
  * 6.7及之前的版本：/sdcard/log/tencent/liteav
  * 6.8之后的版本：/sdcard/Android/data/包名/files/log/tencent/liteav/

#### 常见问题

更多常见问题参考[文档](https://cloud.tencent.com/document/product/647/51623)

##### iOS无法显示视频（Android是好的）

请确认 io.flutter.embedded_views_preview为`YES`在你的info.plist中

##### Android Manifest merge failed编译失败

请打开/example/android/app/src/main/AndroidManifest.xml文件。

1.将xmlns:tools="http://schemas.android.com/tools" 加入到manifest中

2.将tools:replace="android:label"加入到application中。

![图示](https://main.qcloudimg.com/raw/7a37917112831488423c1744f370c883.png)
