//
//  FormularioContatoViewController.h
//  CaelumIP67
//
//  Created by Caio Incau on 30/07/12.
//  Copyright (c) 2012 Caio Incau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "ListaContatosProtocol.h"

@interface FormularioContatoViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>


@property(nonatomic,strong) NSMutableArray *contatos;
@property(strong) Contato *contato;
@property(nonatomic,weak) IBOutlet UITextField *campoNome;
@property(nonatomic,weak) IBOutlet UITextField *campoTelefone;
@property(nonatomic,weak) IBOutlet UITextField *campoEmail;
@property(nonatomic,weak) IBOutlet UITextField *campoEndereco;
@property(nonatomic,weak) IBOutlet UITextField *campoSite;
@property(nonatomic,weak) IBOutlet UITextField *campoTwitter;
@property(nonatomic,weak) IBOutlet UITextField *campoLatitude;
@property(nonatomic,weak) IBOutlet UITextField *campoLongitude;

@property(nonatomic,weak) IBOutlet UIButton *botaoFoto;
@property UITextField *campoAtual;
@property id<ListaContatosProtocol> delegate;

-(Contato *)pegaDadosDoFormulario;
-(id)initWithContato:(Contato *)contato;
-(IBAction)escondeTeclado:(UITextView *)sender;
-(IBAction)selecionaFoto:(id)sender;
@end
