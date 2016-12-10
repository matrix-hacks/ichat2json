//
//  InstantMessage.h
//  ichat2json
//
//  Created by Keyvan Fatehi on 12/9/16.
//  Copyright © 2016 Keyvan Fatehi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sender.h"

@interface InstantMessage : NSObject <NSCoding /* Decoding only */>

@property (readonly, copy) NSDate *date;
@property (readonly, copy) NSAttributedString *message;
@property (readonly, copy) Sender *sender;
- (NSString *) toJSONString;
@end