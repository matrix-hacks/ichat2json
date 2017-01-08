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
    _subject = [decoder decodeObjectForKey:@"Subject"];
    _date = [decoder decodeObjectForKey:@"Time"];
    _message = [decoder decodeObjectForKey:@"OriginalMessage"];
    NSAttributedString *attrMsg = [decoder decodeObjectForKey:@"MessageText"];

    _attachmentName = [self getAttributeWithKey:@"__kIMFilenameAttributeName" fromAttributedString:attrMsg];
    _attachmentGUID = [self getAttributeWithKey:@"__kIMFileTransferGUIDAttributeName" fromAttributedString:attrMsg];
    return self;
}

- (NSString *) getAttributeWithKey: (NSString *)attrKey fromAttributedString:(NSAttributedString *)attrStr
{
    NSRange effectiveRange = NSMakeRange(0, 0);
    return [attrStr attribute:attrKey atIndex:NSMaxRange(effectiveRange) effectiveRange:&effectiveRange];
}

- (void)encodeWithCoder:(NSCoder *)encoder;
{ NSAssert1(NO, @"%@ does not allow encoding.", [self class]); }

- (NSString *) toJSONString;
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    NSString *dateStr = [dateFormat stringFromDate:_date];
    bool isMultiParty = _subject == nil; // multi party chats lack a "subject"
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [_sender accountName], @"sender",
                          [_sender serviceName], @"service",
                          _message == nil ? [NSNull null] : _message, @"message",
                          dateStr, @"date",
                          [NSNumber numberWithBool:isMultiParty], @"isMultiParty",
                          isMultiParty ? [NSNull null] : [_subject accountName], @"subject",
                          _attachmentName, @"attachmentName",
                          _attachmentGUID, @"attachmentGUID",
                          nil];

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
