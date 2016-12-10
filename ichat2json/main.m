//
//  main.m
//  ichat2json
//
//  Created by Keyvan Fatehi on 12/9/16.
//  Copyright © 2016 Keyvan Fatehi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstantMessage.h"
#import "Sender.h"
#import "StubCoder.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc < 2)
        {
            fprintf(stderr, "Usage: %s path/to/ichat\n", argv[0]);
            exit(-1);
        }
        
        NSURL *f = [NSURL fileURLWithPath:[NSString stringWithUTF8String:argv[1]]];
        [NSKeyedUnarchiver setClass:[InstantMessage class] forClassName:@"InstantMessage"];
        [NSKeyedUnarchiver setClass:[StubCoder class] forClassName:@"NSFont"];
        [NSKeyedUnarchiver setClass:[StubCoder class] forClassName:@"NSMutableParagraphStyle"];
        [NSKeyedUnarchiver setClass:[Sender class] forClassName:@"Presentity"];
        for (id object in [NSKeyedUnarchiver unarchiveObjectWithFile: [f path]]) {
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
