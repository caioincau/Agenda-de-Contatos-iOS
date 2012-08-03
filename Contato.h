//
//  Contato.h
//  CaelumIP67
//
//  Created by Caio Incau on 30/07/12.
//  Copyright (c) 2012 Caio Incau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
@interface Contato : NSObject <NSCoding,MKAnnotation>

@property(strong) NSString *nome;
@property(strong) NSString *telefone;
@property(strong) NSString *email;
@property(strong) NSString *endereco;
@property(strong) NSString *site;
@property(strong) NSString *twitter;
@property(strong) NSNumber *latitude;
@property(strong) NSNumber *longitude;
@property(strong) UIImage *foto;


@end
