//
//  ContatosNoMapaViewController.m
//  CaelumIP67
//
//  Created by Caio Incau on 02/08/12.
//  Copyright (c) 2012 Caio Incau. All rights reserved.
//

#import "ContatosNoMapaViewController.h"
#import <MapKit/MKUserTrackingBarButtonItem.h>
#import "Contato.h"
#import "FormularioContatoViewController.h"
@interface ContatosNoMapaViewController ()

@end


@implementation ContatosNoMapaViewController

@synthesize mapa,contatos;
- (id)init
{
    self = [super init];
    if (self) {
        UIImage *imagemTabItem = [UIImage imageNamed:@"mapa-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:imagemTabItem tag:0];

        self.navigationItem.title = @"Localizacao";
        self.tabBarItem = tabItem;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    if([control isKindOfClass:[UIButton class]]){
        Contato *contato = view.annotation;
        FormularioContatoViewController *form = [[FormularioContatoViewController alloc]initWithContato:contato];
        [self.navigationController pushViewController:form animated:YES];
        NSLog(@"NOME :%@",contato.nome);
    }

}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:(id <MKAnnotation>) annotation]) {
        return nil;
    }
    
    static NSString *identifier = @"pino";
    MKPinAnnotationView *pino = (MKPinAnnotationView *)[mapa dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(!pino){
        pino = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    else{
        pino.annotation = annotation;
    }
    
    Contato *contato = (Contato *) annotation;
    pino.pinColor = MKPinAnnotationColorRed;
    
    pino.canShowCallout = YES;
    
    if(contato.foto){
        UIImageView *imagemContato = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,32,32)];
        imagemContato.image = contato.foto;
        pino.leftCalloutAccessoryView = imagemContato;
        pino.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    return pino;
    
}

- (void)viewDidLoad
{
    MKUserTrackingBarButtonItem *botaoLocalizacao = [[MKUserTrackingBarButtonItem alloc]initWithMapView:self.mapa];
    self.navigationItem.rightBarButtonItem=botaoLocalizacao;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(-23, -46);
    MKCoordinateRegion adjustedRegion = [self.mapa regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 10000000, 10000000)];
    [self.mapa setRegion:adjustedRegion animated:YES];
    [self.mapa addAnnotations:contatos];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.mapa removeAnnotations:contatos];
}
@end
