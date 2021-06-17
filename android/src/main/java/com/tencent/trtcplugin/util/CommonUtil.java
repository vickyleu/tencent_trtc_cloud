package com.tencent.trtcplugin.util;

import com.tencent.rtmp.TXLog;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;
/**
 * 工具类
 */

public class CommonUtil {
    private static final String TAG = "TRTCCloudFlutter";
    
    /**
     * 通用方法，获得参数值，如未找到参数，则直接中断
     */
    public static <T> T getParam(MethodCall methodCall, Result result, String param) {
        T parameter = methodCall.argument(param);
        if (parameter == null) {
            result.error("Missing parameter", "Cannot find parameter `" + param + "` or `" + param + "` is null!", 5);
            TXLog.e(TAG, "|method=" + methodCall.method + "|arguments=null");
        }
        return parameter;
    }

    /**
     * 通用方法，获得参数值，参数可以为null
     */
    public static <T> T getParamCanBeNull(MethodCall methodCall, Result result, String param) {
        T parameter = methodCall.argument(param);
        return parameter;
    }
}
