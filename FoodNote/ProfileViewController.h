//
//  ProfileViewController.h
//  FoodNote
//
//  Created by Ishan .
//  Copyright (c) 2557 BE __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "NotesViewController.h"


@interface ProfileViewController : UIViewController
 
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property(strong,nonatomic)PFUser *currentUser;
 

@end
