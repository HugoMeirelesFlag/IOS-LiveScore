//
//  LeagueTableViewCell.h
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 11/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeagueTableViewCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *leagueId;
@property (strong,nonatomic) IBOutlet UILabel *leagueName;
@property (strong,nonatomic) IBOutlet UILabel *leagueCountry;


@end

NS_ASSUME_NONNULL_END
