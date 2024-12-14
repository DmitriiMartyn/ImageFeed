//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Дмитрий Мартынцов on 03.06.2024.
//
import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
}
