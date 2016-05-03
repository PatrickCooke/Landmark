//
//  AppDelegate.m
//  Landmark
//
//  Created by Patrick Cooke on 5/2/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import "AppDelegate.h"
#import "Landmarks.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.thepatrickcooke.Landmark" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Landmark" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Landmark.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:true], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:true], NSInferMappingModelAutomaticallyOption, nil];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Landmark Generation Method

- (void)tempAddRecords {
    Landmarks *newLandmark1 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
    [newLandmark1 setLandmarkName:@"The Iron Yard"];
    [newLandmark1 setLandmarkAddress:@"1001 Woodward Ave, Detroit, MI 48226"];
    [newLandmark1 setLandmarkLat:@"42.332013"];
    [newLandmark1 setLandmarkLon:@"-83.047633"];
    [newLandmark1 setLandmarkImageName:@"ironyarddetroit.jpg"];
    [newLandmark1 setLandmarkDescript:@"Detroit’s weight can be felt throughout America’s history, measured in manufacturing and steel. Home to roughly half of Michigan’s population, the Motor City region's grit is as apparent as ever as it rebuilds new, modern-day industries where the old have gone away. We’re excited to partner with scrappy startups and Fortune 500 companies alike to provide the talent Detroit needs to build the software products of tomorrow."];
    [newLandmark1 setLandmarkURL:@"https://www.theironyard.com/locations/detroit.html"];
    [newLandmark1 setLandmarkPhone:@"3135664825"];
    Landmarks *newLandmark2 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
    [newLandmark2 setLandmarkName:@"Campus Martius Park"];
    [newLandmark2 setLandmarkAddress:@"800 Woodward Ave, Detroit, MI 48226"];
    [newLandmark2 setLandmarkLat:@"42.331545"];
    [newLandmark2 setLandmarkLon:@"-83.046847"];
    [newLandmark2 setLandmarkImageName:@"campusmartius.jpg"];
    [newLandmark2 setLandmarkDescript:@"Campus Martius Park anchors a two square block district that is the commercial center and heart of downtown Detroit. Surrounded by over 6.5 million square feet of mixed used space from the stunning historic architecture of the landmark Penobscot Building to the contemporary Compuware and Quicken Loans Headquarters and One Kennedy Square Buildings, the Campus Martius district is a regional destination. All of the major avenues radiate out from Detroit’s Point of Origin in the Park. The Campus Martius district is a 24-hour neighborhood comprised of 20,000 office employees, 750 residents, 35+ dining options, 50 retail outlets, the Westin Book Cadillac Hotel, 10,000 Parking spaces and over two million annual visitors."];
    [newLandmark2 setLandmarkURL:@"http://www.campusmartiuspark.org/"];
    [newLandmark2 setLandmarkPhone:@"3139620101"];
    Landmarks *newLandmark3 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
    [newLandmark3 setLandmarkName:@"PunchBowlSocial"];
    [newLandmark3 setLandmarkAddress:@"1331 Broadway St, Detroit, MI 48226"];
    [newLandmark3 setLandmarkLat:@"42.334823"];
    [newLandmark3 setLandmarkLon:@"-83.046446"];
    [newLandmark3 setLandmarkImageName:@"punchbowlsocial.jpg"];
    [newLandmark3 setLandmarkDescript:@"Beer, Bowling and friends... we couldn't come up with a third B"];
    [newLandmark3 setLandmarkURL:@"http://punchbowlsocial.com/detroit/"];
    [newLandmark3 setLandmarkPhone:@"3137499738"];
    Landmarks *newLandmark4 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
    [newLandmark4 setLandmarkName:@"Comerica Park"];
    [newLandmark4 setLandmarkAddress:@"2100 Woodward Ave, Detroit, MI 48201"];
    [newLandmark4 setLandmarkLat:@"42.339293"];
    [newLandmark4 setLandmarkLon:@"-83.048873"];
    [newLandmark4 setLandmarkImageName:@"comericapark.jpg"];
    [newLandmark4 setLandmarkDescript:@"Comerica Park is an open-air ballpark located in Downtown Detroit. It serves as the home of the Detroit Tigers of Major League Baseball, replacing Tiger Stadium in 2000."];
    [newLandmark4 setLandmarkURL:@"http://detroit.tigers.mlb.com/det/ballpark/"];
    [newLandmark4 setLandmarkPhone:@"3139624000"];
    Landmarks *newLandmark5 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
    [newLandmark5 setLandmarkName:@"Ford Field"];
    [newLandmark5 setLandmarkAddress:@"2000 Brush St, Detroit, MI 48226"];
    [newLandmark5 setLandmarkLat:@"42.339799"];
    [newLandmark5 setLandmarkLon:@"-83.045548"];
    [newLandmark5 setLandmarkImageName:@"fordfield.jpg"];
    [newLandmark5 setLandmarkDescript:@"Ford Field is a multi-purpose indoor stadium located in Downtown Detroit, Michigan, United States, owned by the Detroit/Wayne County Stadium Authority."];
    [newLandmark5 setLandmarkURL:@"http://www.detroitlions.com/ford-field/"];
    [newLandmark5 setLandmarkPhone:@"3132622000"];
    Landmarks *newLandmark6 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
    [newLandmark6 setLandmarkName:@"The Fillmore Detroit"];
    [newLandmark6 setLandmarkAddress:@"2115 Woodward Ave, Detroit, MI 48201"];
    [newLandmark6 setLandmarkLat:@"42.337854"];
    [newLandmark6 setLandmarkLon:@"-83.051834"];
    [newLandmark6 setLandmarkImageName:@"thefillmoredetroit.jpg"];
    [newLandmark6 setLandmarkDescript:@"The Fillmore Detroit is a multi-use entertainment venue operated by Live Nation. Built in 1925, the Fillmore Detroit was known for most of its history as the State Theatre, and prior to that as the Palms Theatre."];
    [newLandmark6 setLandmarkURL:@"http://www.thefillmoredetroit.com"];
    [newLandmark6 setLandmarkPhone:@"3139615451"];
    Landmarks *newLandmark7 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
    [newLandmark7 setLandmarkName:@"The Fowling Warehouse"];
    [newLandmark7 setLandmarkAddress:@"3901 Christopher St, Hamtramck, Michigan 48211"];
    [newLandmark7 setLandmarkLat:@"42.393956"];
    [newLandmark7 setLandmarkLon:@"-83.044206"];
    [newLandmark7 setLandmarkImageName:@"fowlingwarehouse.jpg"];
    [newLandmark7 setLandmarkDescript:@"Just in case you are asking, 'what's Fowling?'. First, it's pronounced Foe-ling. Second, you throw a football at bowling pins - simple as that. We have 20 Fowling lanes, a full service bar, a 175 seat beer garden and a stage!"];
    [newLandmark7 setLandmarkURL:@"http://fowlingwarehouse.com/"];
    [newLandmark7 setLandmarkPhone:@"313264-1288"];
    Landmarks *newLandmark8 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
    [newLandmark8 setLandmarkName:@"Atwater Brewery"];
    [newLandmark8 setLandmarkAddress:@"237 Joseph Campau Ave, Detroit, MI 48207"];
    [newLandmark8 setLandmarkLat:@"42.337152"];
    [newLandmark8 setLandmarkLon:@"-83.018559"];
    [newLandmark8 setLandmarkImageName:@"atwaterbrewery.jpg"];
    [newLandmark8 setLandmarkDescript:@"Lively brewery offering a rotating selection of craft beers plus hosting tasting events."];
    [newLandmark8 setLandmarkURL:@"https://www.atwaterbeer.com"];
    [newLandmark8 setLandmarkPhone:@"3138779205"];
    Landmarks *newLandmark9 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
    [newLandmark9 setLandmarkName:@"The Dakota Inn"];
    [newLandmark9 setLandmarkAddress:@"17324 John R St, Detroit, MI 48203"];
    [newLandmark9 setLandmarkLat:@"42.419930"];
    [newLandmark9 setLandmarkLon:@"-83.101635"];
    [newLandmark9 setLandmarkImageName:@"dakotainn.jpg"];
    [newLandmark9 setLandmarkDescript:@"Long-running Bavarian-style woody pub serving German fare & beers with weekend piano sing-alongs."];
    [newLandmark9 setLandmarkURL:@"www.dakota-inn.com/"];
    [newLandmark9 setLandmarkPhone:@"3138679722"];
    Landmarks *newLandmark10 = (Landmarks *) [NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
    [newLandmark10 setLandmarkName:@"Moter City Brewing Works"];
    [newLandmark10 setLandmarkAddress:@"470 W Canfield St, Detroit, MI 48201"];
    [newLandmark10 setLandmarkLat:@"42.351831"];
    [newLandmark10 setLandmarkLon:@"-83.066087"];
    [newLandmark10 setLandmarkImageName:@"motercitybrewworks.jpg"];
    [newLandmark10 setLandmarkDescript:@"Small brewpub with a warm vibe & local art serves brick-oven pizzas with flagship & seasonal beers."];
    [newLandmark10 setLandmarkURL:@"www.motorcitybeer.com/"];
    [newLandmark10 setLandmarkPhone:@"3138322700"];
    [self saveContext];
}

- (NSArray*)fetchLandmarks {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"landmarkName" ascending:true];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    NSError *error;
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchResults;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
