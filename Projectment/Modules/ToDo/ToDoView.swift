//
//  ToDoView.swift
//  Projectment
//
//  Created by Anar on 10.05.2020.
//    Copyright © 2020 Anar. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
struct ToDoPreview: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }

  struct ContainerView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ToDoPreview.ContainerView>) -> UIViewController {
      ToDoViewController(context: TasksContext.shared, style: .grouped)
    }

    func updateUIViewController(_ uiViewController: ToDoPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ToDoPreview.ContainerView>) { }
  }
}

import UIKit

final class ToDoViewController: BaseEntityTableViewController<TasksContext, Task>, ToDoViewProtocol {
  // MARK: properties
  var configurator : ToDoConfiguratorProtocol!
  var presenter    : ToDoViewPresenterProtocol!
}

// MARK: - Life Cycle

extension ToDoViewController {
  override func viewWillAppear(_ animated: Bool) {
    self.presenter.viewWillAppear()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    super.generalDelegate = self
    super.tasksContextDelegate = self
    self.configurator = ToDoConfigurator(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}

extension ToDoViewController: BaseEntityTableViewControllerDelegate {
  func deleteEntity(with id: String?) {
    self.presenter.deleteTask(with: id)
  }
  
  func addEntityButton() {
    self.presenter.addTaskButton()
  }
}

extension ToDoViewController: BaseEntityTableViewControllerTasksContextDelegate {
  var screen: Screen {
    .toDo
  }
  
  func showTeamListButton() {
    self.presenter.showTeamListButton()
  }
  
  func changeTaskState(with id: String?, to state: TaskState) {
    self.presenter.changeTaskState(with: id, to: state)
  }
  
  func whoButton(with id: String?) {
    self.presenter.whoButton(with: id)
  }
  
  func dateButton(with id: String?) {
    self.presenter.dateButton(with: id)
  }}

// MARK: - Data

extension ToDoViewController: ToDoViewDataProtocol {
  func setTasks(for tasks: [Task]?) {
    super.entities = tasks
  }
}

// MARK: - UI Making

extension ToDoViewController: ToDoUIProtocol {
  func makeNavBar() {
    self.navigationItem.title = "To Do"
  }
  
  func makeTabBar() {
    self.tabBarController?.tabBar.isHidden = false
  }
  
  func makeTeammateInfoView(for teammate: Teammate?) {
    let alert = UIAlertController(title: "\(teammate?.name ?? "") \(teammate?.lastName ?? "")", message: "ID: \(teammate?.id ?? "")\nJob: \(teammate?.job.rawValue ?? "")\nPost: \(teammate?.post.rawValue ?? "")", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func makeDateInfoView(for created: Date?, _ expires: Date?) {
    var alert: UIAlertController
    
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss dd.MM.yyyy EEEE"
    
    guard let createdDate = created else { return }
    
    if let expiresDate = expires {
      alert = UIAlertController(title: "Dates", message: "Created: \(formatter.string(from: createdDate))\nExpires: \(formatter.string(from: expiresDate))", preferredStyle: UIAlertController.Style.alert)
    } else {
      alert = UIAlertController(title: "Dates", message: "Created: \(formatter.string(from: createdDate))\nExpires: Never", preferredStyle: UIAlertController.Style.alert)
    }
    
    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
