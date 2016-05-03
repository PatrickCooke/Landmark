//
//  DetailsViewController.m
//  Landmark
//
//  Created by Patrick Cooke on 5/2/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "DetailsViewController.h"
#import "AppDelegate.h"


@interface DetailsViewController ()

@property (nonatomic,weak) IBOutlet UILabel *landmarkNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *landmarkAddressLabel;
@property (nonatomic,weak) IBOutlet UITextView *landmarkPhoneTextView;
@property (nonatomic,weak) IBOutlet UITextView *landmarkURLTextView;
@property (nonatomic,weak) IBOutlet UITextView *landmarkDescriptTextView;
@property (nonatomic,weak) IBOutlet UIImageView *landmarkPictureImageView;

@end

@implementation DetailsViewController

#pragma mark - Interactivity Method

-(IBAction)whateverButtonPressed:(id)sender {
    NSLog(@"whatever");
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[[NSString stringWithFormat:@"I just saw %@, and I loved it!",_currentLandmark.landmarkName]] applicationActivities:nil];
    [self.navigationController presentViewController:activityVC animated:true completion:nil];
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _landmarkNameLabel.text = _currentLandmark.landmarkName;
    _landmarkAddressLabel.text = _currentLandmark.landmarkAddress;
    _landmarkPhoneTextView.text = _currentLandmark.landmarkPhone;
    _landmarkURLTextView.text = _currentLandmark.landmarkURL;
    _landmarkDescriptTextView.text = _currentLandmark.landmarkDescript;
    _landmarkPictureImageView.image = [UIImage imageNamed:_currentLandmark.landmarkImageName];
    NSLog(@"I just loaded %@",_currentLandmark.landmarkName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
