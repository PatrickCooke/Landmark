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

- (void)viewDidLoad {
    [super viewDidLoad];
    //_landmarkNameLabel.text = currentlandmark.landmarkName
    //_landmarkAddressLabel.text = currentlandmark.landmarkAddress
    //_landmarkPhoneTextView.text = currentlandmark.landmarkPhone
    //_landmarkURLTextView.text = currentlandmark.landmarkURL
    //_landmarkDescriptTextView.text = currentlandmark.landmarkDescript
    //_landmarkPictureImageView.image = 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
