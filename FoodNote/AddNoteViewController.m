//
//  AddNoteViewController.m
//  FoodNote
//
//  Created by Ishan .
//  Copyright (c) 2557 BE __MyCompanyName__. All rights reserved.
//

#import "AddNoteViewController.h"

@implementation AddNoteViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
    self.currentUser=[PFUser currentUser];

}

- (void)viewDidUnload {
	[super viewDidUnload];
}

- (IBAction)pressedCancel:(UIBarButtonItem *)sender {
    [self.delegate didCancel];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)pressedAdd:(id)sender {
    
    NSString *detail=[self.txtDetail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    PFObject *myLocal=[PFObject objectWithClassName:@"Local"];
    [myLocal setObject:detail forKey:@"name"];
    [myLocal pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"succ");
        [myLocal saveEventually];
    }];
    
   
}

- (IBAction)pressDone:(UIBarButtonItem *)sender {
    
    NSString *detail=[self.txtDetail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    PFObject *myPost=[PFObject objectWithClassName:@"Post"];
    [myPost setObject:detail forKey:@"detail"];
    [myPost setObject:self.currentUser forKey:@"user"];
    
    [myPost saveEventually];
    [self.delegate addPostObject:myPost];
    
//    [myPost pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            
//            [self.delegate addPostObject:myPost];
//            [myPost saveEventually];
//            
//        }else{
//            NSLog(@"Error %@",error);
//        }
//    }];
 
    
    [self.navigationController popViewControllerAnimated:YES];
     
    
}

- (IBAction)pressedGet:(UIButton *)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query fromLocalDatastore];
//    [query whereKey:@"playerName" equalTo:@"Joe Bob"];
    
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
      if(error){
          NSLog(@"Error : %@",[error.userInfo objectForKey:@"error"]);
      
      }else{
          NSLog(@"HAS : %@",objects);
      
      }
  }];
    
}
@end
