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


@interface ViewController ()

@property(nonatomic,strong)             CLLocationManager *locationMgr;
@property(nonatomic,strong) IBOutlet    MKMapView         *landmarkMap;
@property (nonatomic, strong)           AppDelegate            *appDelegate;
@property (nonatomic, strong)           NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)           NSArray                *landmarkArray;


@end

@implementation ViewController

//#pragma mark - Landmark Generation Method
//
//- (void)tempAddRecords {
//    Landmarks *newLandmark1 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
//    [newLandmark1 setLandmarkName:@"The Iron Yard"];
//    [newLandmark1 setLandmarkAddress:@"1001 Woodward Ave, Detroit, MI 48226"];
//    [newLandmark1 setLandmarkLat:@"42.332013"];
//    [newLandmark1 setLandmarkLon:@"-83.047633"];
//    [newLandmark1 setLandmarkImageName:@"ironyarddetroit.jpg"];
//    [newLandmark1 setLandmarkDescript:@"Detroit’s weight can be felt throughout America’s history, measured in manufacturing and steel. Home to roughly half of Michigan’s population, the Motor City region's grit is as apparent as ever as it rebuilds new, modern-day industries where the old have gone away. We’re excited to partner with scrappy startups and Fortune 500 companies alike to provide the talent Detroit needs to build the software products of tomorrow."];
//    [newLandmark1 setLandmarkURL:@"https://www.theironyard.com/locations/detroit.html"];
//    [newLandmark1 setLandmarkPhone:@"3135664825"];
//    Landmarks *newLandmark2 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
//    [newLandmark2 setLandmarkName:@"Campus Martius Park"];
//    [newLandmark2 setLandmarkAddress:@"800 Woodward Ave, Detroit, MI 48226"];
//    [newLandmark2 setLandmarkLat:@"42.331545"];
//    [newLandmark2 setLandmarkLon:@"-83.046847"];
//    [newLandmark2 setLandmarkImageName:@"campusmartiua.jpg"];
//    [newLandmark2 setLandmarkDescript:@"Campus Martius Park anchors a two square block district that is the commercial center and heart of downtown Detroit. Surrounded by over 6.5 million square feet of mixed used space from the stunning historic architecture of the landmark Penobscot Building to the contemporary Compuware and Quicken Loans Headquarters and One Kennedy Square Buildings, the Campus Martius district is a regional destination. All of the major avenues radiate out from Detroit’s Point of Origin in the Park. The Campus Martius district is a 24-hour neighborhood comprised of 20,000 office employees, 750 residents, 35+ dining options, 50 retail outlets, the Westin Book Cadillac Hotel, 10,000 Parking spaces and over two million annual visitors."];
//    [newLandmark2 setLandmarkURL:@"http://www.campusmartiuspark.org/"];
//    [newLandmark2 setLandmarkPhone:@"3139620101"];
//    Landmarks *newLandmark3 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
//    [newLandmark3 setLandmarkName:@"PunchBowlSocial"];
//    [newLandmark3 setLandmarkAddress:@"1331 Broadway St, Detroit, MI 48226"];
//    [newLandmark3 setLandmarkLat:@"42.334823"];
//    [newLandmark3 setLandmarkLon:@"-83.046446"];
//    [newLandmark3 setLandmarkImageName:@"punchbowlsocial.jpg"];
//    [newLandmark3 setLandmarkDescript:@"Beer, Bowling and friends... we couldn't come up with a third B"];
//    [newLandmark3 setLandmarkURL:@"http://punchbowlsocial.com/detroit/"];
//    [newLandmark3 setLandmarkPhone:@"3137499738"];
//    Landmarks *newLandmark4 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
//    [newLandmark4 setLandmarkName:@"Comerica Park"];
//    [newLandmark4 setLandmarkAddress:@"2100 Woodward Ave, Detroit, MI 48201"];
//    [newLandmark4 setLandmarkLat:@"42.339293"];
//    [newLandmark4 setLandmarkLon:@"-83.048873"];
//    [newLandmark4 setLandmarkImageName:@"comericapark.jpg"];
//    [newLandmark4 setLandmarkDescript:@"Comerica Park is an open-air ballpark located in Downtown Detroit. It serves as the home of the Detroit Tigers of Major League Baseball, replacing Tiger Stadium in 2000."];
//    [newLandmark4 setLandmarkURL:@"http://detroit.tigers.mlb.com/det/ballpark/"];
//    [newLandmark4 setLandmarkPhone:@"3139624000"];
//    Landmarks *newLandmark5 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
//    [newLandmark5 setLandmarkName:@"Ford Field"];
//    [newLandmark5 setLandmarkAddress:@"2000 Brush St, Detroit, MI 48226"];
//    [newLandmark5 setLandmarkLat:@"42.339799"];
//    [newLandmark5 setLandmarkLon:@"-83.045548"];
//    [newLandmark5 setLandmarkImageName:@"fordfield.jpg"];
//    [newLandmark5 setLandmarkDescript:@"Ford Field is a multi-purpose indoor stadium located in Downtown Detroit, Michigan, United States, owned by the Detroit/Wayne County Stadium Authority."];
//    [newLandmark5 setLandmarkURL:@"http://www.detroitlions.com/ford-field/"];
//    [newLandmark5 setLandmarkPhone:@"3132622000"];
//    Landmarks *newLandmark6 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
//    [newLandmark6 setLandmarkName:@"The Fillmore Detroit"];
//    [newLandmark6 setLandmarkAddress:@"2115 Woodward Ave, Detroit, MI 48201"];
//    [newLandmark6 setLandmarkLat:@"42.337854"];
//    [newLandmark6 setLandmarkLon:@"-83.051834"];
//    [newLandmark6 setLandmarkImageName:@"thefillmoredetroit.jpg"];
//    [newLandmark6 setLandmarkDescript:@"The Fillmore Detroit is a multi-use entertainment venue operated by Live Nation. Built in 1925, the Fillmore Detroit was known for most of its history as the State Theatre, and prior to that as the Palms Theatre."];
//    [newLandmark6 setLandmarkURL:@"http://www.thefillmoredetroit.com"];
//    [newLandmark6 setLandmarkPhone:@"3139615451"];
//    Landmarks *newLandmark7 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
//    [newLandmark7 setLandmarkName:@"The Fowling Warehouse"];
//    [newLandmark7 setLandmarkAddress:@"3901 Christopher St, Hamtramck, Michigan 48211"];
//    [newLandmark7 setLandmarkLat:@"42.393956"];
//    [newLandmark7 setLandmarkLon:@"-83.044206"];
//    [newLandmark7 setLandmarkImageName:@"fowlingwarehouse.jpg"];
//    [newLandmark7 setLandmarkDescript:@"Just in case you are asking, 'what's Fowling?'. First, it's pronounced Foe-ling. Second, you throw a football at bowling pins - simple as that. We have 20 Fowling lanes, a full service bar, a 175 seat beer garden and a stage!"];
//    [newLandmark7 setLandmarkURL:@"http://fowlingwarehouse.com/"];
//    [newLandmark7 setLandmarkPhone:@"313264-1288"];
//    Landmarks *newLandmark8 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
//    [newLandmark8 setLandmarkName:@"Atwater Brewery"];
//    [newLandmark8 setLandmarkAddress:@"237 Joseph Campau Ave, Detroit, MI 48207"];
//    [newLandmark8 setLandmarkLat:@"42.337152"];
//    [newLandmark8 setLandmarkLon:@"-83.018559"];
//    [newLandmark8 setLandmarkImageName:@"atwaterbrewery.jpg"];
//    [newLandmark8 setLandmarkDescript:@"Lively brewery offering a rotating selection of craft beers plus hosting tasting events."];
//    [newLandmark8 setLandmarkURL:@"https://www.atwaterbeer.com"];
//    [newLandmark8 setLandmarkPhone:@"3138779205"];
//    Landmarks *newLandmark9 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
//    [newLandmark9 setLandmarkName:@"The Dakota Inn"];
//    [newLandmark9 setLandmarkAddress:@"17324 John R St, Detroit, MI 48203"];
//    [newLandmark9 setLandmarkLat:@"42.419930"];
//    [newLandmark9 setLandmarkLon:@"-83.101635"];
//    [newLandmark9 setLandmarkImageName:@"dakotainn.jpg"];
//    [newLandmark9 setLandmarkDescript:@"Long-running Bavarian-style woody pub serving German fare & beers with weekend piano sing-alongs."];
//    [newLandmark9 setLandmarkURL:@"www.dakota-inn.com/"];
//    [newLandmark9 setLandmarkPhone:@"3138679722"];
//    Landmarks *newLandmark10 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
//    [newLandmark10 setLandmarkName:@"Moter City Brewing Works"];
//    [newLandmark10 setLandmarkAddress:@"470 W Canfield St, Detroit, MI 48201"];
//    [newLandmark10 setLandmarkLat:@"42.351831"];
//    [newLandmark10 setLandmarkLon:@"-83.066087"];
//    [newLandmark10 setLandmarkImageName:@"motercitybrewworks.jpg"];
//    [newLandmark10 setLandmarkDescript:@"Small brewpub with a warm vibe & local art serves brick-oven pizzas with flagship & seasonal beers."];
//    [newLandmark10 setLandmarkURL:@"www.motorcitybeer.com/"];
//    [newLandmark10 setLandmarkPhone:@"3138322700"];
//    [_appDelegate saveContext];
//}
//
//- (NSArray*)fetchLandmarks {
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
//    [fetchRequest setEntity:entity];
////    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"landmarkName" ascending:true];
////    [fetchRequest setSortDescriptors:@[sortDescriptor]];
//    NSError *error;
//    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    return fetchResults;
//}

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
//this code is responsable for moving to a detail screen, general and not specific to pin. Needs a prepare for segue to pass over info
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"Tapped %@", view.annotation.title);
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
    
    NSLog(@"Adding %li pins",_appDelegate.landmarkArray.count);
    for (Landmarks *currentlandmark in _appDelegate.landmarkArray) {
        MKPointAnnotation *lm1 = [[MKPointAnnotation alloc]init];
        lm1.coordinate = CLLocationCoordinate2DMake([currentlandmark.landmarkLat floatValue], [currentlandmark.landmarkLon floatValue]);
        lm1.title = currentlandmark.landmarkName;
        lm1.subtitle = currentlandmark.landmarkAddress;
        [_landmarkMap addAnnotation:lm1];
    }

}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailsViewController *destController = [segue destinationViewController];
    // ZERO NEEDS TO CHANGE
    destController.currentLandmark = _appDelegate.landmarkArray[0];
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
