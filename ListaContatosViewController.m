//
//  ListaContatosViewController.m
//  CaelumIP67
//
//  Created by Caio Incau on 31/07/12.
//  Copyright (c) 2012 Caio Incau. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"
@implementation ListaContatosViewController

@synthesize contatos;
- (id)init
{
    self = [super init];
    if (self) {
        UIBarButtonItem *botaoDireito = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeForm)];
        UIImage *imagemTabItem = [UIImage imageNamed:@"lista-contatos.png"];
        UITabBarItem *tabItem =[[UITabBarItem alloc]initWithTitle:@"Contatos" image:imagemTabItem tag:0];
        self.tabBarItem = tabItem;
        self.navigationItem.title=@"Contatos";
        self.navigationItem.rightBarButtonItem = botaoDireito;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    Contato *c = [self.contatos objectAtIndex:sourceIndexPath.row];
    [contatos removeObjectAtIndex:sourceIndexPath.row];
    [contatos insertObject:c atIndex:destinationIndexPath.row];
}

-(void)exibeMaisAcoes:(UIGestureRecognizer *) gesture{
    if(gesture.state ==UIGestureRecognizerStateBegan){
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        Contato *contato = [contatos objectAtIndex:index.row];
        contatoSelecionado = contato;
        UIActionSheet *opcoes = [[UIActionSheet alloc]initWithTitle:contato.nome delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar",@"Enviar Email",@"Visitar Site", @"Abrir Mapa",@"Tweet", nil];
        [opcoes showInView:self.view];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
            
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self mostraMapa];
            break;
        case 4:
            [self tweet];
            break;
            
        default:
            break;
    }

}

-(void) abrirAplicativoComURL:(NSString *)url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


-(void) tweet{
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc]init];
    [twitter setInitialText:contatoSelecionado.twitter];
    [self presentModalViewController:twitter animated:YES];


}
-(void) ligar{
    UIDevice *device = [UIDevice currentDevice];
    if([device.model isEqualToString:@"iPhone"]){
        NSString *numero = [NSString stringWithFormat:@"tel:%@",contatoSelecionado.telefone];
        [self abrirAplicativoComURL:numero];
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"Impossivel Fazer Ligacao" message:@"Seu Dispositivo nao e um iPhone" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]show];
    }
}

-(void) abrirSite{
    NSString *url =[NSString stringWithFormat:@"http://%@",contatoSelecionado.site];
    [self abrirAplicativoComURL:url];
}

-(void) mostraMapa{
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",contatoSelecionado.endereco]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirAplicativoComURL:url];
}

-(void)enviarEmail{
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *enviadorEmail = [[MFMailComposeViewController alloc]init];
        enviadorEmail.mailComposeDelegate= self;
        [enviadorEmail setToRecipients:[NSArray arrayWithObject:contatoSelecionado.email]];
        [enviadorEmail setSubject:@"Caelum"];
        [self presentModalViewController:enviadorEmail animated:YES];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ops" message:@"You cannot send an email" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(exibeMaisAcoes:)];
    [self.tableView addGestureRecognizer:longPress];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contatos count];
}

-(void) contatoAtualizado:(Contato *)contato{
    NSLog(@"atualizando %d",[self.contatos indexOfObject:contato]);
}

-(void) contatoAdicionado:(Contato *)contato{
    NSLog(@"adicionando %d",[self.contatos indexOfObject:contato]);
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.contatos removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Contato *contato = [self.contatos objectAtIndex:indexPath.row];
    FormularioContatoViewController *form = [[FormularioContatoViewController alloc]initWithContato:contato ];
    form.delegate = self;
    form.contatos = self.contatos;

    [self.navigationController pushViewController:form animated:YES
     ];
    NSLog(@"Nome : %@", contato.nome);
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    Contato *contato = [self.contatos objectAtIndex:indexPath.row];
    cell.textLabel.text = contato.nome;
    cell.detailTextLabel.text = contato.email;
    cell.imageView.image = resizeImageToSize(contato.foto,CGSizeMake(40.0, 40.0));
    return cell;
    
}
UIImage* resizeImageToSize(UIImage* image, CGSize size)
{
    UIGraphicsBeginImageContext(size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //Account for flipped coordspace
    CGContextTranslateCTM(ctx, 0.0, size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    
    CGContextDrawImage(ctx,CGRectMake(0.0f, 0.0f, size.width, size.height), image.CGImage);
    
    UIImage* scaled = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return scaled;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(void) exibeForm {
//    NSLog(@"Exibindo Form");
//    UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Mudar de Tela" message:@"Tem certeza que deseja mudar de tela?" delegate:(self) cancelButtonTitle:@"Nao" otherButtonTitles:@"Sim", nil];
//    [alerta show];
    FormularioContatoViewController *formulario = [[FormularioContatoViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:formulario];
    formulario.contatos = self.contatos;
    formulario.delegate = self;
    [self presentModalViewController:nav animated:YES];
}

-(void) dealloc{
    self.contatos = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    NSLog(@"Total Cadastrado : %d", [self.contatos count]);
}
@end
