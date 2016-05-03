//
//  DetailsViewController.h
//  Landmark
//
//  Created by Patrick Cooke on 5/2/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Landmarks.h"
#import <MapKit/MapKit.h>

@interface DetailsViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) Landmarks *currentLandmark;

@end
