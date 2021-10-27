//
//  CustomTabBarDelegate.swift
//  LikeTok
//
//  Created by Daniil Stelchenko on 26.10.21.
//

protocol CustomTabBarDelegate: AnyObject {
    func cardTabBar(_ sender: CustomTabBarView, didSelectItemAt index: Int, previousItemAt previousIndex: Int)
    func shouldSelect(_ sender: CustomTabBarView, shouldSelectItemAt index: Int) -> Bool
}
