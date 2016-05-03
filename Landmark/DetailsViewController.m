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

@property (nonatomic,weak) IBOutlet UILabel     *landmarkNameLabel;
@property (nonatomic,weak) IBOutlet UITextView  *landmarkAddressTextView;
@property (nonatomic,weak) IBOutlet UITextView  *landmarkPhoneTextView;
@property (nonatomic,weak) IBOutlet UITextView  *landmarkURLTextView;
@property (nonatomic,weak) IBOutlet UITextView  *landmarkDescriptTextView;
@property (nonatomic,weak) IBOutlet UIImageView *landmarkPictureImageView;
@property (nonatomic,weak) IBOutlet UITextView  *directionsTextView;
@property (nonatomic,weak) IBOutlet MKMapView   *directionsMapView;

@end

@implementation DetailsViewController

#pragma mark - Interactivity Method

-(IBAction)whateverButtonPressed:(id)sender {
    NSLog(@"whatever");
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[[NSString stringWithFormat:@"I just saw %@, and I loved it!",_currentLandmark.landmarkName]] applicationActivities:nil];
    [self.navigationController presentViewController:activityVC animated:true completion:nil];
}

#pragma mark - Directions and Routing

- (IBAction)getDirections:(id)sender {
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *placemark = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([_currentLandmark.landmarkLat floatValue], [_currentLandmark.landmarkLon floatValue]) addressDictionary:nil]];
    request.destination = placemark;
    request.requestsAlternateRoutes = NO;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error){
         if (error) {
             NSLog(@"Error: %@",error);
         } else {
             NSString *directions = @"";
             for (MKRoute *route in response.routes) {
                 [_directionsMapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
                 [_directionsMapView showAnnotations:[_directionsMapView annotations] animated:true];
                 for (MKRouteStep *step in route.steps) {
                     NSLog(@"%@",step.instructions);
                     directions = [directions stringByAppendingFormat:@"%@\n",step.instructions];
                     
                 }
             }
             self.directionsTextView.text = directions;
         }
     }];
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        routeRenderer.strokeColor = [UIColor orangeColor];
        return routeRenderer;
    }
    return nil;
}

#pragma mark - PinView Methods

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    NSLog(@"VFA");
    if (annotation != mapView.userLocation) {
        NSLog(@"Not UL");
        MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
        if (pinView == nil) {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        }
        pinView.canShowCallout = false;
        pinView.image = [UIImage imageNamed:@"detroiticon2"];
        return pinView;
    } else {
        //nothing for now
    }
    return nil;
}


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _landmarkNameLabel.text = _currentLandmark.landmarkName;
    _landmarkAddressTextView.text = _currentLandmark.landmarkAddress;
    _landmarkPhoneTextView.text = _currentLandmark.landmarkPhone;
    _landmarkURLTextView.text = _currentLandmark.landmarkURL;
    _landmarkDescriptTextView.text = _currentLandmark.landmarkDescript;
    _landmarkPictureImageView.image = [UIImage imageNamed:_currentLandmark.landmarkImageName];
    NSLog(@"I just loaded %@",_currentLandmark.landmarkName);
    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    pa.coordinate = CLLocationCoordinate2DMake([_currentLandmark.landmarkLat floatValue], [_currentLandmark.landmarkLon floatValue]);
    [_directionsMapView addAnnotation:pa];


}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
        [_directionsMapView showAnnotations:[_directionsMapView annotations] animated:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
