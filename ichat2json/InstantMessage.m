//
//  InstantMessage.m
//  ichat2json
//
//  Created by Keyvan Fatehi on 12/9/16.
//  Copyright © 2016 Keyvan Fatehi. All rights reserved.

#import "InstantMessage.h"

@implementation InstantMessage
- (id)initWithCoder:(NSCoder *)decoder;
{
    if (!(self = [super init]))
        return nil;
    _sender = [decoder decodeObjectForKey:@"Sender"];
    _date = [decoder decodeObjectForKey:@"Time"];
    _message = [decoder decodeObjectForKey:@"MessageText"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder;
{ NSAssert1(NO, @"%@ does not allow encoding.", [self class]); }

- (NSString *) toJSONString;
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    NSString *dateStr = [dateFormat stringFromDate:_date];
    NSString *msg = [_message string];
    NSString *senderName = [_sender accountName];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:senderName, @"sender", msg, @"message", dateStr, @"date", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
       jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
@end
