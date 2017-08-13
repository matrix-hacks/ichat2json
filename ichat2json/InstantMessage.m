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
    _files = [[NSMutableArray alloc] init];
    _isMultiParty = false;
    _isRead = [(NSNumber*)[decoder decodeObjectForKey:@"IsRead"] integerValue] == 1 ? true : false;
    NSAttributedString *attrMsg = [decoder decodeObjectForKey:@"MessageText"];
    NSArray *fileIds = [self getAttributesWithKey:@"__kIMFilenameAttributeName" fromAttributedString:attrMsg];
    NSArray *fileNames = [self getAttributesWithKey:@"__kIMFileTransferGUIDAttributeName" fromAttributedString:attrMsg];
    [fileIds enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *fileId = [fileIds objectAtIndex:idx];
        NSString *fileName = [fileNames objectAtIndex:idx];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:fileId, @"id", fileName, @"name", nil];
        [_files addObject:dict];
    }];
    return self;
}

- (NSArray *) getAttributesWithKey: (NSString *)attrKey fromAttributedString:(NSAttributedString *)attrStr
{
    NSRange effectiveRange = NSMakeRange(0, 0);
    NSMutableArray *mArray = [NSMutableArray array];
    id value;
    while (NSMaxRange(effectiveRange) < [attrStr length]) {
        value = [attrStr attribute:attrKey atIndex:NSMaxRange(effectiveRange) effectiveRange:&effectiveRange];
        if (value != nil) {
            [mArray addObject:value];
        }
    }
    return [mArray copy];
}

- (void)encodeWithCoder:(NSCoder *)encoder;
{ NSAssert1(NO, @"%@ does not allow encoding.", [self class]); }

- (NSString *) toJSONString;
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    NSString *dateStr = [dateFormat stringFromDate:_date];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [_sender accountName], @"sender",
                          [_sender serviceName], @"service",
                          _message == nil ? [NSNull null] : _message, @"message",
                          dateStr, @"date",
                          [NSNumber numberWithBool:_isMultiParty], @"isMultiParty",
                          [NSNumber numberWithBool:_isRead], @"isRead",
                          _subject ? [_subject accountName] : [NSNull null], @"subject",
                          [_participantIds allObjects], @"participantIds",
                          _chatId, @"chatId",
                          _files, @"files",
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
