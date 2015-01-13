//
//  SignupViewController.h
//  FoodNote
//
//  Created by Ishan .
//  Copyright (c) 2557 BE __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "DXAlertView.h"
#import "Utilities.h"
 

@interface SignupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property(strong,nonatomic)Utilities *utility;



- (IBAction)pressedSignup:(id)sender;
@end
