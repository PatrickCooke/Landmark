//
//  ViewController.m
//  Landmark
//
//  Created by Patrick Cooke on 5/2/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "ViewController.h"
#import "Landmarks.h"


@interface ViewController ()

@property(nonatomic,strong)             CLLocationManager *locationMgr;
@property(nonatomic,strong) IBOutlet    MKMapView         *landmarkMap;

@end

@implementation ViewController

#pragma mark - Landmark Generation Method

#pragma mark - Map View Methods

-(void)zoomToPins {
    [_landmarkMap showAnnotations:[_landmarkMap annotations] animated:true];
    //this is a very easy way to cause the map to zoom to determined pin(s), limitation is that it zooms to all annotations (including youself)
}

-(void)zoomToLocationWithLat:(float)latitude andLon:(float)longitude andDiam:(float)diameter {
    if (latitude == 0 && longitude == 0) {
        NSLog(@"You gave me bad data");
    } else {
        CLLocationCoordinate2D zoomLoc = CLLocationCoordinate2DMake(latitude, longitude);
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLoc, diameter, diameter);
        MKCoordinateRegion adjustedRegion = [_landmarkMap regionThatFits:viewRegion];
        [_landmarkMap setRegion:adjustedRegion animated:true];
    }
}

#pragma mark - Location Methods

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *lastLoc = locations.lastObject;
    NSLog(@"LastLoc: %f, %f", lastLoc.coordinate.latitude, lastLoc.coordinate.longitude);
    [self zoomToLocationWithLat:lastLoc.coordinate.latitude andLon:lastLoc.coordinate.longitude andDiam:50000];
}

-(void)turnOnLocationMonitoring {
    [_locationMgr startUpdatingLocation]; // startUpdatingLocation offers lots of data, can also startUpdatingSignificant changes
    _landmarkMap.showsUserLocation = true;
}

-(void)setupLocationMonitoring {
    _locationMgr = [[CLLocationManager alloc]init];
    _locationMgr.delegate = self;
    _locationMgr.desiredAccuracy = kCLLocationAccuracyBest; //be nice to users, use less intense method for better battery life
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"Location Services enabled");
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusAuthorizedAlways:
                [self turnOnLocationMonitoring];
                break;
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                [self turnOnLocationMonitoring];
                break;
            case kCLAuthorizationStatusDenied:
                NSLog(@"please turn this back on!");
                break;
            case kCLAuthorizationStatusNotDetermined:
                NSLog(@"Please allow this app to use location data");
                if ([_locationMgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                    [_locationMgr requestWhenInUseAuthorization];
                }
                break;
            case kCLAuthorizationStatusRestricted:
                NSLog(@"please turn this back on!");
                break;
            default:
                break;
        }
    } else {
        NSLog(@"Turn on Location Services in Settings");
    }
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
