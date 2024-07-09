//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Дмитрий Мартынцов on 04.07.2024.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}

final class AuthViewController: UIViewController {
    
    @IBOutlet private weak var authButton: UIButton!
    
    private let segueIdentifier = "ShowWebView"
    private let oAuth2Service = OAuth2Service()
    private let oAuth2TokenStorage = OAuth2TokenStorage()
    
    weak var delegate: AuthViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
        
        authButton.layer.cornerRadius = 16
                authButton.layer.masksToBounds = true
            }

            @IBAction private func didTapLoginButton(_ sender: UIButton) {

            }

            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == segueIdentifier,
                   let viewController = segue.destination as? WebViewViewController {
                    viewController.delegate = self
                            } else {
                                super.prepare(for: segue, sender: sender)
                            }
                        }

                        @IBAction private func didTapAuthButton(_ sender: Any?) {

                        }
                    }

                    extension AuthViewController: WebViewViewControllerDelegate {
                        func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
                            self.delegate?.authViewController(self, didAuthenticateWithCode: code)
                                    }

                                    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
                                        vc.dismiss(animated: true)
                                    }
                                }

                                extension AuthViewController {
                                    override var preferredStatusBarStyle: UIStatusBarStyle {
                                        return .lightContent
                                    }
                                }
