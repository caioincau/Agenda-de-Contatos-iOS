//
//  FormularioContatoViewController.m
//  CaelumIP67
//
//  Created by Caio Incau on 30/07/12.
//  Copyright (c) 2012 Caio Incau. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"

@interface FormularioContatoViewController ()

@end


@implementation FormularioContatoViewController
//construtor, digitar init e dar esc, gera construtor
- (id)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title = @"Cadastro";
        UIBarButtonItem *cancela = [[UIBarButtonItem alloc]initWithTitle:@"Cancela" style:UIBarButtonItemStylePlain target:self action:(@selector(escondeFormulario))];
        self.navigationItem.leftBarButtonItem = cancela;
        
        UIBarButtonItem *adiciona =[[UIBarButtonItem alloc]initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criaContato)];
        self.navigationItem.rightBarButtonItem = adiciona;
    }
    return self;
}

- (id)initWithContato:(Contato *)_contato
{
    self = [super init];
    if (self) {
        self.contato = _contato;
        UIBarButtonItem *adiciona =[[UIBarButtonItem alloc]initWithTitle:@"Confirmar" style:UIBarButtonItemStylePlain target:self action:@selector(altera)];
        self.navigationItem.rightBarButtonItem = adiciona;
        self.navigationItem.title = @"Alterar";
    }
    return self;
}


@synthesize campoEmail,campoEndereco,campoNome,campoSite,campoTelefone,contatos,contato,delegate,campoTwitter,botaoFoto;

-(void)altera{
    Contato *contatoAtualizado = [self pegaDadosDoFormulario];
    [self.navigationController popViewControllerAnimated:YES];
    if(self.delegate){
        [self.delegate contatoAtualizado:contatoAtualizado];
    }
}

-(IBAction)selecionaFoto:(id)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
    
    }
    else{
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [botaoFoto setImage:imagemSelecionada forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}

-(Contato *)pegaDadosDoFormulario{
    if (!self.contato){
        contato = [[Contato alloc]init];
    }
    contato.nome = campoNome.text;
    contato.telefone = campoTelefone.text;
    contato.email = campoEmail.text;
    contato.endereco = campoEndereco.text;
    contato.site = campoSite.text;
    contato.twitter = campoTwitter.text;
    return contato;
//    NSLog(@"contato com nome: %i",[self.contatos count]);
//    NSMutableDictionary *dadosDoContato=[[NSMutableDictionary alloc]init];
//    [dadosDoContato setObject:[campoNome text] forKey:@"nome"];
//    [dadosDoContato setObject:[campoTelefone text] forKey:@"telefone"];
//    [dadosDoContato setObject:[campoEmail text] forKey:@"email"];
//    [dadosDoContato setObject:[campoEndereco text] forKey:@"endereco"];
//  [dadosDoContato setObject:[campoSite text] forKey:@"site"];
//    NSLog(@"dados :%@",dadosDoContato);
//    StringWithFormat:@"%@ e tambem %@",O que vai no primeiro campo,o que vai no segundo;
}

-(void) criaContato{
        [self.contatos addObject:[self pegaDadosDoFormulario]];
        [self dismissModalViewControllerAnimated:YES];
    if(self.delegate){
        [self.delegate contatoAtualizado:contato];
    }
}

-(void)limpaForm{
    [campoNome setText:@""];
    [campoTelefone setText:@""];
    [campoEmail setText:@""];
    [campoEndereco setText:@""];
    [campoTelefone setText:@""];
    [campoSite setText:@""];
    [campoTwitter setText:@""];
}

-(IBAction)escondeTeclado:(UITextView *)sender{
    [sender resignFirstResponder];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(void) escondeFormulario {
    [self dismissModalViewControllerAnimated:YES];
}


-(void) viewDidLoad{
    if(self.contato){
        campoNome.text = contato.nome;
        campoTelefone.text = contato.telefone;
        campoEmail.text = contato.email;
        campoEndereco.text = contato.endereco;
        campoSite.text = contato.site;
        campoTwitter.text = contato.twitter;
    }
}
@end
