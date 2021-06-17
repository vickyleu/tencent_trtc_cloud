//
//  TencentVideoTextureRender.m
//  tencent_trtc_cloud
//
//  Created by aydenli on 2021/3/30.
//

#import "TencentVideoTextureRender.h"
#import "libkern/OSAtomic.h"
#import <Accelerate/Accelerate.h>

@implementation TencentVideoTextureRender
{
    CVPixelBufferRef _target;
    FrameUpdateCallback _callback;
}

- (instancetype)initWithFrameCallback:(FrameUpdateCallback)calback {
    if(self = [super init]) {
        _callback = calback;
    }
    return self;
}

- (CVPixelBufferRef)copyPixelBuffer {
    return _target;
}

- (void)onRenderVideoFrame:(TRTCVideoFrame *)frame userId:(NSString *)userId streamType:(TRTCVideoStreamType)streamType {
    @try
    {
        if(frame.pixelBuffer != NULL) {
            @synchronized(self){
                _target = frame.pixelBuffer;
                CVBufferRetain(_target);
                _callback();
            }
        }
    }
    @catch(NSException *exception)
    {
        //异常处理代码
    }
    
}

// void pixelBufferReleaseCallBack(void *releaseRefCon, const void *baseAddress) {
//     if (baseAddress != NULL) {
//         free((void *)baseAddress);
//     }
// }

// void assertCropAndScaleValid(CVPixelBufferRef pixelBuffer, CGRect cropRect, CGSize scaleSize) {
//     CGFloat originalWidth = (CGFloat)CVPixelBufferGetWidth(pixelBuffer);
//     CGFloat originalHeight = (CGFloat)CVPixelBufferGetHeight(pixelBuffer);
    
//     assert(CGRectContainsRect(CGRectMake(0, 0, originalWidth, originalHeight), cropRect));
//     assert(scaleSize.width > 0 && scaleSize.height > 0);
// }

// Returns a CVPixelBufferRef with +1 retain count
// CVPixelBufferRef createCroppedPixelBuffer(CVPixelBufferRef sourcePixelBuffer, CGRect croppingRect, CGSize scaledSize) {
    
//     OSType inputPixelFormat = CVPixelBufferGetPixelFormatType(sourcePixelBuffer);
    
//     if(inputPixelFormat != kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange
//        && inputPixelFormat != kCVPixelFormatType_420YpCbCr8BiPlanarFullRange) {
//         return nil;
//     }
    
//     assertCropAndScaleValid(sourcePixelBuffer, croppingRect, scaledSize);
    
//     if (CVPixelBufferLockBaseAddress(sourcePixelBuffer, kCVPixelBufferLock_ReadOnly) != kCVReturnSuccess) {
//         NSLog(@"AydenTest Could not lock base address");
//         return nil;
//     }
    
//     void *sourceData = CVPixelBufferGetBaseAddress(sourcePixelBuffer);
//     if (sourceData == NULL) {
//         NSLog(@"AydenTest Error: could not get pixel buffer base address");
//         CVPixelBufferUnlockBaseAddress(sourcePixelBuffer, kCVPixelBufferLock_ReadOnly);
//         return nil;
//     }
    
//     size_t sourceBytesPerRow = CVPixelBufferGetBytesPerRow(sourcePixelBuffer);
//     NSLog(@"AydenTest sourceBytesPerRow:%zu",sourceBytesPerRow);
//     vImage_Buffer croppedvImageBuffer = {
//         .data = ((char *)sourceData),
//         .height = (vImagePixelCount)CGRectGetHeight(croppingRect),
//         .width = (vImagePixelCount)CGRectGetWidth(croppingRect),
//         .rowBytes = sourceBytesPerRow
//     };
    
//     size_t scaledBytesPerRow = scaledSize.width * (sourceBytesPerRow / croppingRect.size.width);
//     void *scaledData = malloc(scaledSize.height * scaledBytesPerRow);
//     if (scaledData == NULL) {
//         NSLog(@"AydenTest Error: out of memory");
//         CVPixelBufferUnlockBaseAddress(sourcePixelBuffer, kCVPixelBufferLock_ReadOnly);
//         return nil;
//     }
    
//     vImage_Buffer scaledvImageBuffer = {
//         .data = scaledData,
//         .height = (vImagePixelCount)scaledSize.height,
//         .width = (vImagePixelCount)scaledSize.width,
//         .rowBytes = scaledBytesPerRow
//     };
    
//     vImage_Error error = vImageScale_Planar8(&croppedvImageBuffer, &scaledvImageBuffer, nil, 0);
//     CVPixelBufferUnlockBaseAddress(sourcePixelBuffer, kCVPixelBufferLock_ReadOnly);
    
//     if (error != kvImageNoError) {
//         NSLog(@"AydenTest Error: %ld", error);
//         free(scaledData);
//         return nil;
//     }
    
//     OSType pixelFormat = CVPixelBufferGetPixelFormatType(sourcePixelBuffer);
//     CVPixelBufferRef outputPixelBuffer = NULL;
//     CVReturn status = CVPixelBufferCreateWithBytes(nil, scaledSize.width, scaledSize.height, pixelFormat, scaledData, scaledBytesPerRow, pixelBufferReleaseCallBack, nil, nil, &outputPixelBuffer);
//     if (status != kCVReturnSuccess) {
//         NSLog(@"AydenTest Error: could not create new pixel buffer");
//         free(scaledData);
//         return nil;
//     }
//     return outputPixelBuffer;
// }
@end
