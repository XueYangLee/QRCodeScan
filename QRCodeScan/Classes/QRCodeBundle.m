//
//  QRCodeBundle.m
//  QRCodeScan
//
//  Created by 李雪阳 on 2021/10/12.
//

#import "QRCodeBundle.h"

@implementation QRCodeBundle

+ (NSBundle *)bundle{
    return [self.class bundleWithName:@"QRCodeBundle"];
}


+ (NSBundle *)bundleWithName:(NSString *)bundleName {
    if(bundleName.length == 0) {
        return nil;
    }
    NSBundle *resourceBundle = nil;
    NSBundle *mainBundle = [NSBundle bundleForClass:self];
    NSString *path = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    resourceBundle = [NSBundle bundleWithPath:path]?:mainBundle;
    NSAssert(resourceBundle, @"not found bundle");
    return  resourceBundle;
}


+ (UIImage *)imageNamed:(NSString *)imageName {
    NSAssert([self imageNamed:imageName inBundle:[self.class bundle]], @"not found image");
    return [self imageNamed:imageName inBundle:[self.class bundle]];
}

+ (UIImage *)imageNamed:(NSString *)imageName inBundle:(NSBundle *)bundle {
    if(imageName.length == 0 || !bundle) {
        return nil;
    }
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}


+ (UIImage *)imageNamed:(NSString *)imageName bundleName:(NSString *)bundleName {
    return [self imageNamed:imageName inBundle:[self bundleWithName:bundleName]];
}

@end
