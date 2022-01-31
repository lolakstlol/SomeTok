//
//  CellConfiguration.swift
//  LikeTok
//
//  Created by Daniel on 23.01.22.
//

import class UIKit.UIView

/// Конфигуратор ячейки списка
protocol CellConfiguration: AnyObject {
    /// Идентификатор ячейки. Он будет использоваться в качестве id для переиспользуемой ячейки
    static var cellIdentifier: String { get }
    
    /// Метод установки ячейки
    func setupCell(_ cell: UIView)
    
    /// Метод, которые вызывается при нажатии на кнопку
    func didTapCell()
    
    /// Метод подготовки данных. Реализуется только в случае использования Prefetching API
    func prepareData()
    
    /// Метод отмены подготовки данных. Реализуется только в случае использования Prefetching API
    func cancelPreparingData()
}

extension CellConfiguration {
    func didTapCell() { }
    func prepareData() { }
    func cancelPreparingData() { }
}
