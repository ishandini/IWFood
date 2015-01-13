//
//  LoginViewController.m
//  FoodNote
//
//  Created by Ishan .
//  Copyright (c) 2557 BE __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "NotesViewController.h"


@implementation LoginViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideBackButton];
     self.utility=[[Utilities alloc] init];
    [self.tabBarController.tabBar setHidden:YES];
    [PFUser logOut];
    NSLog(@"User Logout");
    
}

-(void)hideBackButton{
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem=barButton;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)pressedLogin:(id)sender {
    [self.view endEditing:YES];

    NSString *userName=[self.txtUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password=[self.txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(userName.length>0 || password.length>0 ){
        if ([self.utility hasInternet]) {
            [PFUser logInWithUsernameInBackground:userName password:password block:^(PFUser *user, NSError *error) {
                if(error){
                    NSString *errInfo=[error.userInfo objectForKey:@"error"];
                    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Error" contentText:errInfo leftButtonTitle:nil rightButtonTitle:@"Ok"];
                    [alert show];
                }else{
                    /*
                     UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                     
                     NotesViewController *controller=[storyBoard instantiateViewControllerWithIdentifier:@"sid_note"];
                     [self.navigationController pushViewController:controller animated:NO];
                     
                     */
                    
                    [self.tabBarController.tabBar setHidden:NO];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                    
                }
            }];
        }else{
            
            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Oops.." contentText:@"Check internet connection" leftButtonTitle:nil rightButtonTitle:@"Ok"];
            [alert show];
        }
     
        
    }else{
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Oops.." contentText:@"Please Submit Fields" leftButtonTitle:nil rightButtonTitle:@"Ok"];
        [alert show];
        
    }
    
}

 


@end
