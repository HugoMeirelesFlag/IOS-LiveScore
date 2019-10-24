//
//  LeagueAllMatchesTableViewController.h
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 13/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeagueAllMatchesTableViewController : UITableViewController

@property (strong,nonatomic) NSNumber *leagueId;
@property (strong,nonatomic) NSString *leagueName;
@property (strong,nonatomic) NSNumber *leagueMatchDay;


@end

NS_ASSUME_NONNULL_END
