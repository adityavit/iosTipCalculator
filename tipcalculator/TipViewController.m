//
//  TipViewController.m
//  tipcalculator
//
//  Created by Aditya Bhatia on 9/10/14.
//  Copyright (c) 2014 Aditya Bhatia. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (strong, nonatomic) SettingsViewController *settingsControllerObj;
@property BOOL useCustomTipValue;
@property float customTipValue;
- (IBAction)onTap:(id)sender;
- (void) updateValues;
- (float) getTipValue;
- (void) onSettingsButton;
@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL customTipSwitchFlag = [defaults boolForKey:@"custom_tip_switch_flag"];
    self.useCustomTipValue = customTipSwitchFlag;
    if(customTipSwitchFlag) {
        self.customTipValue = [defaults floatForKey:@"custom_tip_value"]/100;
    }
    [self updateValues];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void) updateValues{
    float billValue = [self.billTextField.text floatValue];
    float tipValue = [self getTipValue];
    float tipAmount = billValue * tipValue;
    float totalAmount = tipAmount + billValue;
    self.tipLabel.text = [NSString stringWithFormat:@"%.2f", tipAmount];
    self.amountLabel.text = [NSString stringWithFormat:@"%.2f", totalAmount];
}

- (float) getTipValue {
    if ([self useCustomTipValue]) {
        return self.customTipValue;
    }
    NSArray *tipValues = @[@(0.1), @(0.15) , @(0.2)];
    float selectedTipValue = [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    return selectedTipValue;

}

- (void) onSettingsButton {
    if (!self.settingsControllerObj) {
        self.settingsControllerObj = [[SettingsViewController alloc] init];
    }
    [self.navigationController pushViewController: self.settingsControllerObj animated:YES];
}

@end
