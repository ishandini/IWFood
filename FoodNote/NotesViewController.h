//
//  NotesViewController.h
//  FoodNote
//
//  Created by Ishan .
//  Copyright (c) 2557 BE __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AddNoteViewController.h"  
#import "Utilities.h"
  

@interface NotesViewController : UIViewController<AddNoteViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>


@property(strong,nonatomic)PFUser *currentUser;
@property(strong,nonatomic)Utilities *utility;

@end
