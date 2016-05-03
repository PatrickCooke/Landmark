//
//  ViewController.m
//  Landmark
//
//  Created by Patrick Cooke on 5/2/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "ViewController.h"
#import "Landmarks.h"
#import "AppDelegate.h"
#import "DetailsViewController.h"
#import "MyPointAnnotation.h"


@interface ViewController ()

@property(nonatomic,strong)             CLLocationManager      *locationMgr;
@property(nonatomic,strong) IBOutlet    MKMapView              *landmarkMap;
@property (nonatomic, strong)           AppDelegate            *appDelegate;
@property (nonatomic, strong)           NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, strong)           NSArray                *landmarkArray;
@property (nonatomic, strong)           NSNumber               *selectedPinIndex;


@end

@implementation ViewController


#pragma mark - Map View Methods

-(void)zoomToPins {
    [_landmarkMap showAnnotations:[_landmarkMap annotations] animated:true];
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

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    NSLog(@"VFA");
    if (annotation != mapView.userLocation) {
        NSLog(@"Not UL");
        MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
        if (pinView == nil) {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        }
        pinView.canShowCallout = true;
        pinView.image = [UIImage imageNamed:@"detroiticon2"];
        UIButton *pinButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.rightCalloutAccessoryView = pinButton;
        pinButton.tag = 2; //key for homework tonight
        return pinView;
    } else {
            //nothing for now
    }
    return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"Tapped %@", view.annotation.title);
    MyPointAnnotation *annot = (MyPointAnnotation *)view.annotation;
    _selectedPinIndex = annot.pinIndex;
    NSLog(@"Selected:%@", _selectedPinIndex);
    [self performSegueWithIdentifier:@"MaptoDetail" sender:self];
}

#pragma mark - Location Methods

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *lastLoc = locations.lastObject;
    NSLog(@"LastLoc: %f, %f", lastLoc.coordinate.latitude, lastLoc.coordinate.longitude);
    [self zoomToLocationWithLat:lastLoc.coordinate.latitude andLon:lastLoc.coordinate.longitude andDiam:50000];
}

-(void)turnOnLocationMonitoring {
    [_locationMgr startMonitoringSignificantLocationChanges];
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

-(void)annotateMapLocations {
    NSMutableArray *pinsToRemove = [[NSMutableArray alloc]init];
    for (id <MKAnnotation> annot in [_landmarkMap annotations]) {
        if ([annot isKindOfClass:[MKPointAnnotation class]]) {
            [pinsToRemove addObject: annot];
        }
    }
    [_landmarkMap removeAnnotations:pinsToRemove];
    
    //NSLog(@"Adding %li pins",_appDelegate.landmarkArray.count);
    for (Landmarks *currentlandmark in _appDelegate.landmarkArray) {
        MyPointAnnotation *lm1 = [[MyPointAnnotation alloc] init];
        lm1.coordinate = CLLocationCoordinate2DMake([currentlandmark.landmarkLat floatValue], [currentlandmark.landmarkLon floatValue]);
        lm1.title = currentlandmark.landmarkName;
        lm1.subtitle = currentlandmark.landmarkAddress;
        lm1.pinIndex = [NSNumber numberWithLong:[_appDelegate.landmarkArray indexOfObject:currentlandmark]];
        [_landmarkMap addAnnotation:lm1];
    }

}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailsViewController *destController = [segue destinationViewController];
    destController.currentLandmark = [_appDelegate.landmarkArray objectAtIndex:[_selectedPinIndex longValue]];
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    //[self tempAddRecords];
    _appDelegate.landmarkArray = [_appDelegate fetchLandmarks];
    NSLog(@"total records %li",_appDelegate.landmarkArray.count);
    [self annotateMapLocations];
    [self zoomToPins];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [self setupLocationMonitoring];
    [self zoomToPins];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
