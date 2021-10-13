//
//  QRCodeBundle.h
//  QRCodeScan
//
//  Created by 李雪阳 on 2021/10/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRCodeBundle : NSBundle

+ (NSBundle *)bundle;


+ (NSBundle *)bundleWithName:(NSString *)bundleName;

+ (UIImage *)imageNamed:(NSString *)imageName;

+ (UIImage *)imageNamed:(NSString *)imageName inBundle:(NSBundle *)bundle;

+ (UIImage *)imageNamed:(NSString *)imageName bundleName:(NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
