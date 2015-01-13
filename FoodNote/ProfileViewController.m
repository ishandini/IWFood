//
//  ProfileViewController.m
//  FoodNote
//
//  Created by Ishan .
//  Copyright (c) 2557 BE __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"
#import "PhotosViewController.h"

@implementation ProfileViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
    
     self.currentUser=[PFUser currentUser];
    NSLog(@"profile didload :%@",[[PFUser currentUser] username]);
    if(self.currentUser){
        self.lblUserName.text=self.currentUser.username;
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
    
    if([self.currentUser isEqual:[PFUser currentUser]] ){
        NSLog(@"profile EQ");
    }else{
         NSLog(@"profile load");
        self.currentUser=[PFUser currentUser];
        self.lblUserName.text=self.currentUser.username;
    }
    
    
    
}


- (void)viewDidUnload {
	[super viewDidUnload];
}




 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // [PFUser logOut];
 }

 




@end
