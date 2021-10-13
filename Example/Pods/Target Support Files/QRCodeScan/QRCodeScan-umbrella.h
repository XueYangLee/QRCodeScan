#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "QRCodeBundle.h"
#import "QRCodeGenerateTools.h"
#import "QRCodeScan.h"
#import "QRCodeScanHeader.h"
#import "QRCodeScanManager.h"
#import "QRCodeScanTools.h"
#import "QRCodeScanView.h"
#import "UIImage+QRCodeExt.h"
#import "UIView+QRCodeExt.h"

FOUNDATION_EXPORT double QRCodeScanVersionNumber;
FOUNDATION_EXPORT const unsigned char QRCodeScanVersionString[];

