//
//  Utilities.m
//  FoodNote
//
//  Created by Ishan .
//  Copyright (c) 2557 BE __MyCompanyName__. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

-(BOOL)hasInternet{
    
    Reachability *networkReachbility=[Reachability reachabilityForInternetConnection];
    NetworkStatus status= [networkReachbility currentReachabilityStatus];
    if(status==NotReachable){
        return NO;
    }
    else{
        return YES;
    }
}

@end
