//
//  Post.m
//  FoodNote
//
//  Created by Ishan .
//  Copyright (c) 2557 BE __MyCompanyName__. All rights reserved.
//

#import "Post.h"

@implementation Post

+(instancetype)defaultPost{

    static Post *post;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        post=[[self alloc] init];
    });
    return post;
}
 
@end
