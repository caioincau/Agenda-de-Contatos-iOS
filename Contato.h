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

@property(nonatomic,strong) NSString *nome;
@property(nonatomic,strong) NSString *telefone;
@property(nonatomic,strong) NSString *email;
@property(nonatomic,strong) NSString *endereco;
@property(nonatomic,strong) NSString *site;
@property(nonatomic,strong) NSString *twitter;
@property(nonatomic,strong) NSNumber *latitude;
@property(nonatomic,strong) NSNumber *longitude;
@property(nonatomic,strong) UIImage *foto;


@end
