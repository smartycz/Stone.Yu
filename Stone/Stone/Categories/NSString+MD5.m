//
//  NSString+MD5.m
//  Stone
//
//  Created by Stone.Yu on 2016/12/14.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

- (NSString *)md5
{
    if (nil == self || self.length == 0) {
        return @"";
    }
    
    const char *cStr = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), outputBuffer);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            outputBuffer[0], outputBuffer[1], outputBuffer[2], outputBuffer[3],
            outputBuffer[4], outputBuffer[5], outputBuffer[6], outputBuffer[7],
            outputBuffer[8], outputBuffer[9], outputBuffer[10], outputBuffer[11],
            outputBuffer[12], outputBuffer[13], outputBuffer[14], outputBuffer[15]
            ];
}

@end
