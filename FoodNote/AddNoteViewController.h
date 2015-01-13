//
//  AddNoteViewController.h
//  FoodNote
//
//  Created by Ishan .
//  Copyright (c) 2557 BE __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@protocol AddNoteViewControllerDelegate <NSObject>

@required
-(void)didCancel;
-(void)addPostObject:(PFObject *)post;

@end

@interface AddNoteViewController : UIViewController

@property(weak, nonatomic)id<AddNoteViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *txtDetail;
@property(strong,nonatomic)PFUser *currentUser;

 
- (IBAction)pressedCancel:(UIBarButtonItem *)sender;

- (IBAction)pressedAdd:(id)sender;

- (IBAction)pressDone:(UIBarButtonItem *)sender;

- (IBAction)pressedGet:(UIButton *)sender;

@end
