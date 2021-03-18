//
//  APIManager+Activities.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation
import Combine

extension Resource {

  // MARK: [GET] - Get calls to display in the Activity Feed
  static func getActivities() -> Resource<[Activity]> {
    let url = Constants.BaseURL.appendingPathComponent(Routes.activities.description)
    return Resource<[Activity]>(url: url)
  }

  // MARK: [GET] - Retrieve a specific call details
  static func getActivitiesBy(id: Int) -> Resource<Activity> {
    let url = Constants.BaseURL.appendingPathComponent(Routes.activitiesBy(id: id).description)
    return Resource<Activity>(url: url)
  }

  // MARK: [GET] - Reset all calls to initial state
  static func resetCalls() -> Resource<Call> {
    let url = Constants.BaseURL.appendingPathComponent(Routes.resetCalls.description)
    return Resource<Call>(url: url)
  }

  // MARK: [POST] - Update a specific call
  static func updateActivitiesBy(id: Int) -> Resource<Activity> {
    let url = Constants.BaseURL.appendingPathComponent(Routes.archiveActivity(id: id).description)
    let body = ["is_archived": true]
    return Resource<Activity>(url: url, method: .post, body: body)
  }

}

