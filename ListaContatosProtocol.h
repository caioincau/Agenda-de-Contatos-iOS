//
//  ListaContatosProtocol.h
//  CaelumIP67
//
//  Created by Caio Incau on 01/08/12.
//  Copyright (c) 2012 Caio Incau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@protocol ListaContatosProtocol <NSObject>

-(void) contatoAtualizado: (Contato *) contato;
-(void) contatoAdicionado: (Contato *) contato;
@end
