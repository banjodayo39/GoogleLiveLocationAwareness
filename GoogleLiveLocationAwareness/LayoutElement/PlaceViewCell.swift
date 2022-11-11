//
//  PlaceViewCell.swift
//  GoogleLiveLocationAwareness
//
//  Created by Dayo Banjo on 10/29/22.
//

import UIKit

class PlaceViewCell: UITableViewCell {
    
    static let identifier = "PlaceViewCell"
    
    var thumbnailImageView  = UIImageView(frame: .zero)
    var titleLabel  =  UILabel(frame: .zero)
    var descriptionLabel  =  UILabel(frame: .zero)
    
    let button = UIButton(frame: .zero)
    var onButtonTap : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            contentView.backgroundColor = UIColor.blue
        } else {
            contentView.backgroundColor = UIColor.clear

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 20))
    }
    
    func setUpViews(){
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.addSubviews(thumbnailImageView, descriptionLabel, titleLabel, button) 
        titleLabel.textColor = .white.withAlphaComponent(0.6)
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        thumbnailImageView.reSize(size: CGSize(width: 80, height: 60))
        thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        thumbnailImageView.layer.cornerRadius = 4
        thumbnailImageView.clipsToBounds = true
        
        descriptionLabel.anchor(top: thumbnailImageView.topAnchor, leading: thumbnailImageView.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        titleLabel.anchor(top: descriptionLabel.bottomAnchor, leading: thumbnailImageView.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16))
        
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = translatesAutoresizingMaskIntoConstraints
        button.reSize(size: CGSize(width: 40, height: 40))
        button.tintColor = .white
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        button.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
    }
    
    func setUp(place : Place) {
        titleLabel.text = place.title
        descriptionLabel.text = place.description
        thumbnailImageView.image = UIImage(named: place.thumbnail)
    }
    
    @objc func didTapOnButton() {
        onButtonTap?()
    }
    
    
}
