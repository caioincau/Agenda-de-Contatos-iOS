//
//  ListaContatosViewController.h
//  CaelumIP67
//
//  Created by Caio Incau on 31/07/12.
//  Copyright (c) 2012 Caio Incau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ListaContatosProtocol.h"
#import "Contato.h"
#import <Twitter/Twitter.h>

@interface ListaContatosViewController : UITableViewController <ListaContatosProtocol,UIActionSheetDelegate,MFMailComposeViewControllerDelegate>
{
Contato *contatoSelecionado;
}
@property(strong) NSMutableArray *contatos;

-(void)exibeMaisAcoes:(UIGestureRecognizer *) gesture;
@end
