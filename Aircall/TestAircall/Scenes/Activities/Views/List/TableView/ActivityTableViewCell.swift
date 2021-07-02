//
//  ActivityTableViewCell.swift
//  TestAircall
//
//  Created by Delphine Garcia on 27/06/2021.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    @UsesAutoLayout private var callLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.layer.masksToBounds = true
        return label
    }()
    
    @UsesAutoLayout private var legendLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    @UsesAutoLayout private var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .right
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        return label
    }()
    
    @UsesAutoLayout private var directionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    @UsesAutoLayout private var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor.secondary
        return imageView
    }()
    
    private let iconInfoSize: CGFloat = 32
    private let iconDirectionSize: CGFloat = 24
    
    var state = ActivitiesFlow.CellState.loading {
        didSet {
            updateViewBasedOn(state: state)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            contentView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        } else {
            contentView.backgroundColor = .clear
        }
    }
}

// MARK: - Private methods
extension ActivityTableViewCell {
    
    private func initialise() {
        backgroundColor = UIColor.background
        selectionStyle = .none
        addAllSubviews()
        applyConstraints()
    }
    
    private func addAllSubviews() {
        contentView.addSubview(directionImageView)
        contentView.addSubview(callLabel)
        contentView.addSubview(legendLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(infoImageView)
    }
    
    private func applyStyles(for state: ActivitiesFlow.CellState) {
        applyDirectionImageViewStyle(for: state)
        applyCallLabelStyle(for: state)
        applyLegendLabelStyle(for: state)
        applyDateLabelStyle(for: state)
        applyInfoImageViewStyle(for: state)
    }
    
    private func applyDirectionImageViewStyle(for state: ActivitiesFlow.CellState) {
        switch state {
        case .loading:
            directionImageView.backgroundColor = UIColor.shimmering
            directionImageView.layer.cornerRadius = iconDirectionSize / 2
            directionImageView.image = nil
        case .result(let activity):
            directionImageView.backgroundColor = UIColor.clear
            directionImageView.layer.cornerRadius = 0
            directionImageView.image = activity.picto
            directionImageView.tintColor = activity.color
        }
    }
    
    private func applyInfoImageViewStyle(for state: ActivitiesFlow.CellState) {
        switch state {
        case .loading:
            infoImageView.backgroundColor = UIColor.shimmering
            infoImageView.layer.cornerRadius = iconInfoSize / 2
            infoImageView.image = nil
        case .result:
            infoImageView.backgroundColor = UIColor.clear
            infoImageView.layer.cornerRadius = 0
            infoImageView.image = UIImage.info
        }
    }
    
    private func applyCallLabelStyle(for state: ActivitiesFlow.CellState) {
        switch state {
        case .loading:
            callLabel.text = "Number"
            callLabel.textColor = UIColor.shimmering
            callLabel.backgroundColor = UIColor.shimmering
            callLabel.layer.cornerRadius = 10
        case .result(let activity):
            callLabel.text = activity.call
            callLabel.textColor = UIColor.primary
            callLabel.backgroundColor = .clear
            callLabel.layer.cornerRadius = 0
        }
    }
    
    private func applyLegendLabelStyle(for state: ActivitiesFlow.CellState) {
        switch state {
        case .loading:
            legendLabel.text = "Legend"
            legendLabel.textColor = UIColor.shimmering
            legendLabel.backgroundColor = UIColor.shimmering
            legendLabel.layer.cornerRadius = 10
        case .result(let activity):
            legendLabel.text = activity.legend
            legendLabel.textColor = UIColor.secondary
            legendLabel.backgroundColor = .clear
            legendLabel.layer.cornerRadius = 0
        }
    }
    
    private func applyDateLabelStyle(for state: ActivitiesFlow.CellState) {
        switch state {
        case .loading:
            dateLabel.text = "Date"
            dateLabel.textColor = UIColor.shimmering
            dateLabel.backgroundColor = UIColor.shimmering
            dateLabel.layer.cornerRadius = 10
        case .result(let activity):
            dateLabel.text = activity.date
            dateLabel.textColor = UIColor.secondary
            dateLabel.backgroundColor = .clear
        }
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            directionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            directionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Charter.Margin.regular.size),
            directionImageView.widthAnchor.constraint(equalToConstant: iconDirectionSize),
            directionImageView.heightAnchor.constraint(equalToConstant: iconDirectionSize)
        ])
        
        NSLayoutConstraint.activate([
            callLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Charter.Margin.regular.size),
            callLabel.leadingAnchor.constraint(equalTo: directionImageView.trailingAnchor, constant: Charter.Margin.regular.size),
            callLabel.bottomAnchor.constraint(equalTo: legendLabel.topAnchor, constant: -Charter.Margin.small.size)
        ])
        
        NSLayoutConstraint.activate([
            legendLabel.topAnchor.constraint(equalTo: callLabel.bottomAnchor, constant: Charter.Margin.small.size),
            legendLabel.leadingAnchor.constraint(equalTo: callLabel.leadingAnchor, constant: 0),
            legendLabel.trailingAnchor.constraint(equalTo: callLabel.trailingAnchor, constant: 0),
            legendLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Charter.Margin.regular.size)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: callLabel.topAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: callLabel.trailingAnchor, constant: Charter.Margin.regular.size),
            dateLabel.bottomAnchor.constraint(equalTo: legendLabel.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            infoImageView.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: Charter.Margin.regular.size),
            infoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Charter.Margin.regular.size),
            infoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            infoImageView.widthAnchor.constraint(equalToConstant: iconInfoSize),
            infoImageView.heightAnchor.constraint(equalToConstant: iconInfoSize)
        ])
    }
    
    private func updateViewBasedOn(state: ActivitiesFlow.CellState) {
        switch state {
        case .loading:
            showShimmering()
        case .result(let activity):
            hideShimmeringAndDisplay(activity)
        }
    }
    
    private func showShimmering() {
        applyStyles(for: .loading)
        contentView.startShimmering()
    }

    private func hideShimmeringAndDisplay(_ activity: ActivityUI) {
        contentView.stopShimmering()
        applyStyles(for: .result(activity))
    }
}
