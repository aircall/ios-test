//
//  ActivityDetailsView.swift
//  TestAircall
//
//  Created by Delphine Garcia on 30/06/2021.
//

import UIKit

class ActivityDetailsView: UIView {
    
    @UsesAutoLayout private var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "Generic_error".localized
        label.isHidden = true
        return label
    }()
    
    @UsesAutoLayout private var mainView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.backgroundColor = UIColor.tertiary
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 0
        return view
    }()
    
    @UsesAutoLayout private var titleView: ViewWithSeparator = {
        let view = ViewWithSeparator(frame: .zero)
        view.backgroundColor = UIColor.background
        return view
    }()
    
    @UsesAutoLayout private var infoView: ViewWithSeparator = {
        let view = ViewWithSeparator(frame: .zero)
        view.backgroundColor = UIColor.tertiary
        return view
    }()
    
    @UsesAutoLayout private var numberView: ViewWithSeparator = {
        let view = ViewWithSeparator(frame: .zero)
        view.backgroundColor = UIColor.tertiary
        return view
    }()
    
    @UsesAutoLayout private var actionsView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.background
        view.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        return view
    }()
    
    @UsesAutoLayout private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = UIColor.primary
        label.text = "Activity_details_call_information".localized
        return label
    }()
    
    @UsesAutoLayout private var directionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    @UsesAutoLayout private var legendLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.primary
        return label
    }()
    
    @UsesAutoLayout private var durationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.secondary
        return label
    }()
    
    @UsesAutoLayout private var numberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.primary
        return label
    }()
    
    private let iconDirectionSize: CGFloat = 24
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        addAllSubviews()
        applyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
// MARK: - Private methods
extension ActivityDetailsView {
    
    private func addAllSubviews() {
        addSubview(errorLabel)
        addSubview(mainView)
        mainView.addArrangedSubview(titleView)
        mainView.addArrangedSubview(infoView)
        mainView.addArrangedSubview(numberView)
        mainView.addArrangedSubview(actionsView)
        titleView.addSubview(titleLabel)
        infoView.addSubview(directionImageView)
        infoView.addSubview(legendLabel)
        infoView.addSubview(durationLabel)
        numberView.addSubview(numberLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mainView.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: Charter.Margin.large.size),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: Charter.Margin.regular.size),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -Charter.Margin.regular.size),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.separator.topAnchor, constant: -Charter.Margin.large.size)
        ])
        
        NSLayoutConstraint.activate([
            directionImageView.centerYAnchor.constraint(equalTo: infoView.centerYAnchor, constant: 0),
            directionImageView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: Charter.Margin.regular.size),
            directionImageView.widthAnchor.constraint(equalToConstant: iconDirectionSize),
            directionImageView.heightAnchor.constraint(equalToConstant: iconDirectionSize)
        ])
        
        NSLayoutConstraint.activate([
            legendLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: Charter.Margin.regular.size),
            legendLabel.leadingAnchor.constraint(equalTo: directionImageView.trailingAnchor, constant: Charter.Margin.regular.size),
            legendLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -Charter.Margin.regular.size),
        ])
        
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(equalTo: legendLabel.bottomAnchor, constant: Charter.Margin.small.size),
            durationLabel.leadingAnchor.constraint(equalTo: directionImageView.trailingAnchor, constant: Charter.Margin.regular.size),
            durationLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -Charter.Margin.regular.size),
            durationLabel.bottomAnchor.constraint(equalTo: infoView.separator.topAnchor, constant: -Charter.Margin.regular.size)
        ])
        
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: numberView.topAnchor, constant: Charter.Margin.regular.size),
            numberLabel.leadingAnchor.constraint(equalTo: numberView.leadingAnchor, constant: Charter.Margin.regular.size * 2 + iconDirectionSize),
            numberLabel.trailingAnchor.constraint(equalTo: numberView.trailingAnchor, constant: -Charter.Margin.regular.size),
            numberLabel.bottomAnchor.constraint(equalTo: numberView.separator.topAnchor, constant: -Charter.Margin.regular.size)
        ])
    }
}

// MARK: - Internal methods
extension ActivityDetailsView {
    
    func displayActivity(_ activity: ActivityDetailsUI) {
        errorLabel.isHidden = true
        mainView.isHidden = false
        directionImageView.image = activity.picto
        directionImageView.tintColor = activity.color
        legendLabel.text = activity.legend
        durationLabel.text = "Activity_details_duration".localized([activity.duration])
        numberLabel.text = activity.call
    }
    
    func displayError() {
        errorLabel.isHidden = false
        mainView.isHidden = true
    }
}
