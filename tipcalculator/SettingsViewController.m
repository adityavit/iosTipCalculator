//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Aditya Bhatia on 9/10/14.
//  Copyright (c) 2014 Aditya Bhatia. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *cutomTipSwitch;
@property (weak, nonatomic) IBOutlet UITextField *customTipText;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL customTipSwitchFlag = [defaults boolForKey:@"custom_tip_switch_flag"];
    if(customTipSwitchFlag) {
        float customTipValue = [defaults floatForKey:@"custom_tip_value"];
        [self.cutomTipSwitch setOn:customTipSwitchFlag];
        [self.customTipText setText:[NSString stringWithFormat:@"%.2f", customTipValue]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL useCustomTipSwitch = [self.cutomTipSwitch isOn];
    [defaults setBool:useCustomTipSwitch forKey:@"custom_tip_switch_flag"];
    if(useCustomTipSwitch) {
        float tipValue = [self.customTipText.text floatValue];
        [defaults setFloat:tipValue forKey:@"custom_tip_value"];
    }
    [defaults synchronize];
}

@end
