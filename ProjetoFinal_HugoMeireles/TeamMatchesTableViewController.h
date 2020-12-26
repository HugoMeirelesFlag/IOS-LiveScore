//
//  ClubGamesTableViewController.h
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 13/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamMatchesTableViewController : UITableViewController

@property (strong,nonatomic) NSNumber *teamId;
@property (strong,nonatomic) NSString *teamName;

@end

NS_ASSUME_NONNULL_END
