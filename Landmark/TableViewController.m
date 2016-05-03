//
//  TableViewController.m
//  Landmark
//
//  Created by Patrick Cooke on 5/3/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "TableViewController.h"
#import "Landmarks.h"
#import "AppDelegate.h"
#import "DetailsViewController.h"

@interface TableViewController ()

@property(nonatomic,weak)     IBOutlet  UITableView            *landmarkTableView;
@property (nonatomic, strong)           AppDelegate            *appDelegate;
@property (nonatomic, strong)           NSManagedObjectContext *managedObjectContext;


@end

@implementation TableViewController


#pragma mark - Table View Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _appDelegate.landmarkArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Landmarks *currentLandmark = _appDelegate.landmarkArray[indexPath.row];
    cell.textLabel.text = currentLandmark.landmarkName;
    cell.detailTextLabel.text = currentLandmark.landmarkAddress;
    return cell;
}


#pragma mark - Segue
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailsViewController *destcontroller = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"TabletoDetail"]) {
        NSIndexPath *indexPath = [_landmarkTableView indexPathForSelectedRow];
        Landmarks *selectedLandmark = _appDelegate.landmarkArray[indexPath.row];
        destcontroller.currentLandmark = selectedLandmark;
    }
}

#pragma mark - Reoccuring Methods

-(void)refreshDrinkTable {
    _appDelegate.landmarkArray = [_appDelegate fetchLandmarks];
    [_landmarkTableView reloadData];
}


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    _appDelegate.landmarkArray = [_appDelegate fetchLandmarks];
    NSLog(@"total records %li",_appDelegate.landmarkArray.count);
    [_landmarkTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
