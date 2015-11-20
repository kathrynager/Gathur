//
//  ImageTapGestureRecognizer.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/18/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit

class ImageTapGestureRecognizer: UITapGestureRecognizer {
   //UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];


    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            var numberOfTapsRequired = 1
            var numberOfTouchesRequired = 1
            

        }
    }
    
    
}
