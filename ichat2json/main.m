//
//  main.m
//  ichat2json
//
//  Created by Keyvan Fatehi on 12/9/16.
//  Copyright © 2016 Keyvan Fatehi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstantMessage.h"
#import "Presentity.h"
#import "StubCoder.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc < 2)
        {
            fprintf(stderr, "Usage: %s path/to/ichat\n", argv[0]);
            exit(-1);
        }
        NSString *filePath = [NSString stringWithUTF8String:argv[1]];
        [NSKeyedUnarchiver setClass:[InstantMessage class] forClassName:@"InstantMessage"];
        [NSKeyedUnarchiver setClass:[Presentity class] forClassName:@"Presentity"];
        
        [NSKeyedUnarchiver setClass:[StubCoder class] forClassName:@"NSFont"];
        [NSKeyedUnarchiver setClass:[StubCoder class] forClassName:@"NSMutableParagraphStyle"];
        [NSKeyedUnarchiver setClass:[StubCoder class] forClassName:@"NSTextAttachment"];
        [NSKeyedUnarchiver setClass:[StubCoder class] forClassName:@"NSColor"];

        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSArray* root = [unarchiver decodeObjectForKey:@"$root"];
        for (id object in root) {
            if ([object isKindOfClass:[NSMutableArray class]]) {
                for (id sub in object) {
                    if ([sub isKindOfClass:[InstantMessage class]]) {
                        InstantMessage *im = (InstantMessage *) sub;                        
                        fprintf(stdout, "%s\n", [[im toJSONString] UTF8String]);
                    }
                }
            }
        }
    }
    return 0;
}
