## 1.0.5
修复安卓视频view销毁后，PlatformException报错问题
## 1.0.4
iOS新增updateLocalView、updateRemoteView接口
## 1.0.3
修复安卓关闭麦克风后，setAudioRoute无效的问题
## 1.0.2
修改文档注释
## 1.0.1
修复安卓roomId超出 2147483647时，无法进房的问题。取值范围支持：1 - 4294967294
## 1.0.0
升级flutter2.0，支持null safety
## 0.2.3
ios 修复onRecvCustomCmdMsgUserId和onRecvSEIMsg返回optional问题
## 0.2.2
TRTC Flutter SDK去除对path_provider的依赖
## 0.2.1
支持屏幕分享 startScreenCapture
## 0.2.0
修复ios viewType指定为surfaceView时的bug
## 0.1.9
修复ios onUserVoiceVolume 回调返回数据的bug
## 0.1.8
优化了一些功能
## 0.1.7
修改为引入Android sdk的线上包
## 0.1.6
进入房间新增strRoomId参数，支持传入字符串房间
## 0.1.5
优化代码结构，更新文档
## 0.1.4
更新文档
## 0.1.3
* TRTCCloudListenerEnum枚举类修改为TRTCCloudListener，该版本不向下兼容。升级到该版本及以上时，需要把事件监听改成TRTCCloudListener
## 0.1.2
* 新增友商云转推接口
## 0.1.1
* 新增自定义消息发送接口
## 0.1.0
* 优化代码，去掉onAudioRouteChanged回调
## 0.0.9
* 修复Xocde运行时的一些warning
## 0.0.8
* 更新文档
## 0.0.7
* 新增startPublishing、stopPublishing、setVideoMuteImage、setLogDirPath、setLogDirPath接口
* 更新原生IOS版本，修复IOS的onError、onSetMixTranscodingConfig回调
## 0.0.6
* 更新文档
## 0.0.5
* TRTCCloud新增connectOtherRoom、disconnectOtherRoom、switchRoom接口
* TXDeviceManager新增enableCameraAutoFocus、isAutoFocusEnabled接口
## 0.0.4
* IOS修复开启耳返设置音效后，有电流声的问题
* Android TRTCCloudVideoView新增viewType参数，支持SurfaceView和TextureView，默认为TextureView
## 0.0.3
* 更新文档
## 0.0.1
* 初始化项目，封装flutter trtc sdk, 基于Android sdk和IOS sdk

