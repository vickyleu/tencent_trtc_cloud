import 'dart:async';
import 'package:flutter/services.dart';

/// 美颜及动效参数管理
class TXBeautyManager {
  static late MethodChannel _channel;
  TXBeautyManager(channel) {
    _channel = channel;
  }

  /// 设置美颜类型
  ///
  /// 参数：
  ///
  /// beautyStyle	美颜风格.三种美颜风格：0 ：光滑 1：自然 2：朦胧
  Future<void> setBeautyStyle(int beautyStyle) {
    return _channel
        .invokeMethod('setBeautyStyle', {"beautyStyle": beautyStyle});
  }

  /// 设置指定素材滤镜特效
  ///
  /// 参数：
  ///
  /// assetUrl可以为flutter中定义的asset资源地址如'images/watermark_img.png'，也可以为网络图片地址
  ///
  /// 注意：必须使用 png 格式
  Future<int?> setFilter(String assetUrl //assets 中的资源地址
      ) async {
    String imageUrl = assetUrl;
    String type = 'network'; //默认为网络图片
    if (assetUrl.indexOf('http') != 0) {
      type = 'local';
    }
    return _channel
        .invokeMethod('setFilter', {"imageUrl": imageUrl, "type": type});
  }

  /// 设置滤镜浓度
  ///
  /// 在美女秀场等应用场景里，滤镜浓度的要求会比较高，以便更加突显主播的差异。 我们默认的滤镜浓度是0.5，如果您觉得滤镜效果不明显，可以使用下面的接口进行调节。
  ///
  /// 参数：
  ///
  /// strength	从0到1，越大滤镜效果越明显，默认值为0.5。
  Future<void> setFilterStrength(double strength) {
    return _channel
        .invokeMethod('setFilterStrength', {"strength": strength.toString()});
  }

  /// 设置美颜级别
  ///
  /// 参数：
  ///
  /// beautyLevel	美颜级别，取值范围0 - 9； 0表示关闭，1 - 9值越大，效果越明显。
  Future<void> setBeautyLevel(int beautyLevel) {
    return _channel
        .invokeMethod('setBeautyLevel', {"beautyLevel": beautyLevel});
  }

  /// 设置美白级别
  ///
  /// 参数：
  ///
  /// whitenessLevel	美白级别，取值范围0 - 9； 0表示关闭，1 - 9值越大，效果越明显。
  Future<void> setWhitenessLevel(int whitenessLevel) {
    return _channel
        .invokeMethod('setWhitenessLevel', {"whitenessLevel": whitenessLevel});
  }

  /// 开启清晰度增强
  ///
  /// 参数：
  ///
  /// enable	true：开启清晰度增强；false：关闭清晰度增强。默认值：true
  Future<void> enableSharpnessEnhancement(bool enable) {
    return _channel
        .invokeMethod('enableSharpnessEnhancement', {"enable": enable});
  }

  /// 设置红润级别
  ///
  /// 参数：
  /// ruddyLevel	红润级别，取值范围0 - 9； 0表示关闭，1 - 9值越大，效果越明显。
  Future<void> setRuddyLevel(int ruddyLevel) {
    return _channel.invokeMethod('setRuddyLevel', {"ruddyLevel": ruddyLevel});
  }
}
