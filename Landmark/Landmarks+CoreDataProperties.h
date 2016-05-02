//
//  Landmarks+CoreDataProperties.h
//  Landmark
//
//  Created by Patrick Cooke on 5/2/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Landmarks.h"

NS_ASSUME_NONNULL_BEGIN

@interface Landmarks (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *landmarkName;
@property (nullable, nonatomic, retain) NSString *landmarkAddress;
@property (nullable, nonatomic, retain) NSDecimalNumber *landmarkLat;
@property (nullable, nonatomic, retain) NSDecimalNumber *landmarkLon;
@property (nullable, nonatomic, retain) NSString *landmarkImageName;
@property (nullable, nonatomic, retain) NSString *landmarkDescript;
@property (nullable, nonatomic, retain) NSString *landmarkURL;
@property (nullable, nonatomic, retain) NSString *landmarkPhone;

@end

NS_ASSUME_NONNULL_END
