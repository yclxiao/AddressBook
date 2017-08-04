//
//  ContactModel.m
//  AddressBook
//
//  Created by yclxiao on 2017/8/4.
//  Copyright © 2017年 yclxiao. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.phone forKey:@"phone"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
    }
    return self;
}

@end
