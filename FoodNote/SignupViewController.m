//
//  SignupViewController.m
//  FoodNote
//
//  Created by Ishan .
//  Copyright (c) 2557 BE __MyCompanyName__. All rights reserved.
//

#import "SignupViewController.h"

@implementation SignupViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
    
 self.utility=[[Utilities alloc] init];
    
    
}

- (void)viewDidUnload {
	[super viewDidUnload];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (IBAction)pressedSignup:(id)sender {
    [self.view endEditing:YES];
    NSString *userName=[self.txtUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
      NSString *password=[self.txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
      NSString *email=[self.txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if(userName.length>0 || password.length>0 || email.length>0){
         if ([self.utility hasInternet]) {
            PFUser *user=[PFUser user];
            user.username=userName;
            user.password=password;
            user.email=email;
             
             [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                 if(error){
                     NSString *errInfo=[error.userInfo objectForKey:@"error"];
                     DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Error" contentText:errInfo leftButtonTitle:nil rightButtonTitle:@"Ok"];
                     [alert show];
                 }else{
                     
                     [self.tabBarController.tabBar setHidden:NO];
                     [self.navigationController popToRootViewControllerAnimated:YES];

                 }
             }];
            
            
        }else{
        
            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Oops.." contentText:@"Check internet connection" leftButtonTitle:nil rightButtonTitle:@"Ok"];
            [alert show];
        }
        
    
    }else{
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Oops.." contentText:@"Please Submit All Fields" leftButtonTitle:nil rightButtonTitle:@"Ok"];
        [alert show];
    
    }
    
}

@end
