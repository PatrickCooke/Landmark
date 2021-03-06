//
//  AppDelegate.h
//  Landmark
//
//  Created by Patrick Cooke on 5/2/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSArray *landmarkArray;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSArray*)fetchLandmarks;
- (void)tempAddRecords;

@end

