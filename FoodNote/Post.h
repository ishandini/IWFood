//
//  Post.h
//  FoodNote
//
//  Created by Ishan .
//  Copyright (c) 2557 BE __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface Post : NSObject


@property(strong,nonatomic)NSMutableArray *myPosts;
+(instancetype)defaultPost;

@end
