//
//  Sender.m
//  ichat2json
//
//  Created by Keyvan Fatehi on 12/9/16.
//  Copyright © 2016 Keyvan Fatehi. All rights reserved.
//

#import "Presentity.h"

@implementation Presentity

@synthesize accountName = _accountName;
@synthesize serviceName = _serviceName;

- (id)initWithCoder:(NSCoder *)decoder;
{
    if (!(self = [super init]))
        return nil;
    _accountName = [decoder decodeObjectForKey:@"ID"];
    _serviceName = [decoder decodeObjectForKey:@"ServiceName"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder;
{ NSAssert1(NO, @"%@ does not allow encoding.", [self class]); }

@end
