//
//  TaskType.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import UIKit

enum TaskType {
  case design
  case management
  case development
  case testing
  case planning
  
  var icon: UIImage? {
    switch self {
    case .design:
      return UIImage(systemName: "pencil")
    case .management:
      return UIImage(systemName: "person.3.fill")
    case .development:
      return UIImage(systemName: "chevron.left.slash.chevron.right")
    case .testing:
      return UIImage(systemName: "hammer.fill")
    case .planning:
      return UIImage(systemName: "calendar")
    }
  }
}
