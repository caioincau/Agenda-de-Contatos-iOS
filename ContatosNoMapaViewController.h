//
//  ContatosNoMapaViewController.h
//  CaelumIP67
//
//  Created by Caio Incau on 02/08/12.
//  Copyright (c) 2012 Caio Incau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>
#import <MapKit/MapKit.h>

@interface ContatosNoMapaViewController : UIViewController <MKMapViewDelegate>

@property(weak,nonatomic) IBOutlet MKMapView *mapa;
@property(weak,nonatomic) NSMutableArray *contatos;
@end
