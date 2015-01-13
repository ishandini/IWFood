//
//  NotesViewController.m
//  FoodNote
//
//  Created by Ishan .
//  Copyright (c) 2557 BE __MyCompanyName__. All rights reserved.
//

#import "NotesViewController.h"



@interface NotesViewController ()
@property(strong,nonatomic)NSMutableArray *posts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NotesViewController{
   int querryLimit;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideBackButton];
    [self addRefreshController];
    self.currentUser=[PFUser currentUser];
    self.utility=[[Utilities alloc] init];
    self.posts=[[NSMutableArray alloc] init];
    if(self.currentUser){
        NSLog(@"has user: %@, count: %lu",self.currentUser.username,(unsigned long)[self.posts count]);
        [self getPost];
    }else{
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
}


-(void)hideBackButton{
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem=barButton;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"noteview didapear");
    NSLog(@"user OLD %@  -- %@",self.currentUser.username,[[PFUser currentUser] username]);
    if([self.currentUser isEqual:[PFUser currentUser]]){
        NSLog(@"EQ");
    }else{
        
        if([[PFUser currentUser] username] != nil){
            self.currentUser=[PFUser currentUser];
             [self getPost];
            NSLog(@"LORD AGAIN");
        }else{
            NSLog(@"current user empty %@ ",[[PFUser currentUser]username ]);
            [self performSegueWithIdentifier:@"showLogin" sender:self];
            
        }
        
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}




#pragma mark -get Parse post

-(void)getPost{
     PFQuery *query=[PFQuery queryWithClassName:@"Post"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"user" equalTo:self.currentUser];
    [query orderByDescending:@"createdAt"];
    query.limit = 10;
    //    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self.posts removeAllObjects];
        [self.posts addObjectsFromArray:objects];
        [self.tableView reloadData];
        NSLog(@"OBJECTS query user: %@, count: %lu",self.currentUser.username,(unsigned long)[self.posts count]);
        
    }];
    
}


#pragma mark -add note delegate

-(void)didCancel{
    NSLog(@"add post cancel");
    NSLog(@"Cancel user: %@, count: %lu",self.currentUser.username,(unsigned long)[self.posts count]);
}

-(void)addPostObject:(PFObject *)post{
    [self.posts insertObject:post atIndex:0];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.posts.count-1  inSection:0]]withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    
    NSLog(@"Add post: %@, count: %lu",self.currentUser.username,(unsigned long)[self.posts count]);
}

#pragma mark-refresh controller

-(void)addRefreshController{
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor=[UIColor colorWithRed:50.0/255 green:180.0/255 blue:120.0/255 alpha:1.0f];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self UpdateRefrshControllerTime:refreshControl];
    [self.tableView addSubview:refreshControl];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
     [self getPost];
    [self UpdateRefrshControllerTime:refreshControl];
    [refreshControl endRefreshing];
}

-(void)UpdateRefrshControllerTime:(UIRefreshControl *)refreshControl{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *title = [NSString stringWithFormat:@"Last updated: %@", [formatter stringFromDate:[NSDate date]]];
    
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    refreshControl.attributedTitle = attributedTitle;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    PFObject *object=[self.posts objectAtIndex:indexPath.row];
    cell.textLabel.text=[object objectForKey:@"detail"];
    
    return cell;
}



#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.destinationViewController isKindOfClass:[AddNoteViewController class]]){
        AddNoteViewController *addNoteVC=segue.destinationViewController;
        addNoteVC.delegate=self;
        
    }
    
}


#pragma mark - UITableView scroll load


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // UITableView only moves in one direction, y axis
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;

    //NSInteger result = maximumOffset - currentOffset;

    // Change 10.0 to adjust the distance from bottom
    if (maximumOffset - currentOffset <= 10.0) {
        NSLog(@"Lord more");
        //[self methodThatAddsDataAndReloadsTableView];
        
        PFQuery *query=[PFQuery queryWithClassName:@"Post"];
        query.cachePolicy = kPFCachePolicyNetworkElseCache;
        [query whereKey:@"user" equalTo:self.currentUser];
        [query orderByDescending:@"createdAt"];
        query.skip=10;
        query.limit = 5;
        //    [query fromLocalDatastore];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
             [self.posts addObjectsFromArray:objects];
            [self.tableView reloadData];
            NSLog(@"OBJECTS query user: %@, count: %lu",self.currentUser.username,(unsigned long)[self.posts count]);
            
        }];
    }
}





@end
