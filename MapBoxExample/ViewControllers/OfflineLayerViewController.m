//
//  OfflineLayerViewController.m
//  MapBox Example
//
//  Created by Justin Miller on 4/5/12.
//  Copyright (c) 2012 MapBox / Development Seed. All rights reserved.
//

#import "OfflineLayerViewController.h"
#import "MapBox.h"
#import <CoreLocation/CoreLocation.h>

@interface OfflineLayerViewController()<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) RMMapView *mapView;
@property (strong, nonatomic) RMMBTilesSource *offlineSource;
@end

@implementation OfflineLayerViewController
@synthesize mapView, offlineSource;

- (void)viewDidLoad
{
    [super viewDidLoad];

    offlineSource = [[RMMBTilesSource alloc] initWithTileSetResource:@"control-room-0.2.0" ofType:@"mbtiles"];
    mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:offlineSource];
    mapView.zoom = 2;
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    mapView.adjustTilesForRetinaDisplay = YES; // these tiles aren't designed specifically for retina, so make them legible
    
    [self.view addSubview:mapView];
}

- (void)viewDidAppear:(BOOL)animated {
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
}

#pragma mark CLLocation delegate methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *locationToKeep = nil;
    for (CLLocation *location in locations) {
        if(location.horizontalAccuracy < 10){
            locationToKeep = location;
        }
    }
    
    if(locationToKeep != nil){
        [mapView setCenterCoordinate:locationToKeep.coordinate animated:YES];
        [mapView setZoom:offlineSource.maxZoom animated:YES];
    }
}

@end