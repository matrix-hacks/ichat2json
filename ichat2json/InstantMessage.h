//
//  InstantMessage.h
//  ichat2json
//
//  Created by Keyvan Fatehi on 12/9/16.
//  Copyright © 2016 Keyvan Fatehi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Presentity.h"

@interface InstantMessage : NSObject <NSCoding /* Decoding only */>

@property (readonly, copy) NSDate *date;
@property (readonly, copy) NSString *message;
@property (readonly, copy) NSMutableArray *files;
@property () BOOL isMultiParty;
@property () BOOL isRead;
@property () NSSet *participantIds;
@property () NSString *chatId;
@property (readonly, copy) Presentity *sender;
@property (readonly, copy) Presentity *subject;
- (NSString *) toJSONString;
@end
