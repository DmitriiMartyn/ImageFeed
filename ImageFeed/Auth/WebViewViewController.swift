//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by Дмитрий Мартынцов on 04.07.2024.
//

import WebKit
import UIKit

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}

final class WebViewViewController: UIViewController {

    @IBOutlet private var webView: WKWebView!
    @IBOutlet private var progressView: UIProgressView!

    weak var delegate: WebViewViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationCapturesStatusBarAppearance = true
        
        webView.navigationDelegate = self
        
        guard var urlComponents = URLComponents(string: authorizeURLString) else {
                   fatalError("Incorrect base URL")
               }

               urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: accessKey),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: accessScope)
        ]
        guard let url = urlComponents.url else {
                   fatalError("Unable to build URL")
               }
        let request = URLRequest(url: url)

                webView.load(request)
                updateProgress()
            }

            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)

                webView.addObserver(
                    self,
                    forKeyPath: #keyPath(WKWebView.estimatedProgress),
                    context: nil)
                updateProgress()
            }

            override func viewDidDisappear(_ animated: Bool) {
                super.viewDidDisappear(animated)
                webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
            }

            override func observeValue(
                forKeyPath keyPath: String?,
                of object: Any?,
                change: [NSKeyValueChangeKey : Any]?,
                context: UnsafeMutableRawPointer?
            ) {
                if keyPath == #keyPath(WKWebView.estimatedProgress) {
                    updateProgress()
                } else {
                    super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
                }
            }

    private func updateProgress() {
        progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        progressView.isHidden = fabs(webView.estimatedProgress - 1.0) <= 0.0001
            }

            @IBAction private func didTapBackButton(_ sender: Any?) {
                delegate?.webViewViewControllerDidCancel(self)
            }
        }

        // MARK: - WKNavigationDelegate extension
        extension WebViewViewController: WKNavigationDelegate {
            func webView(_ webView: WKWebView,
                         decidePolicyFor navigationAction: WKNavigationAction,
                         decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

                if let code = code(from: navigationAction) {
                    delegate?.webViewViewController(self, didAuthenticateWithCode: code)
                    decisionHandler(.cancel)
                } else {
                    decisionHandler(.allow)
                }
            }

            private func code(from navigationAction: WKNavigationAction) -> String? {
                if let url = navigationAction.request.url,
                   let urlComponents = URLComponents(string: url.absoluteString),
                   urlComponents.path == "/oauth/authorize/native",
                   let queryItems = urlComponents.queryItems,
                   let codeItem = queryItems.first(where: { $0.name == "code" })
                {
                    return codeItem.value
                } else {
                    return nil
                }
            }
        }

        // MARK: - Status Bar
        extension WebViewViewController {
            override var preferredStatusBarStyle: UIStatusBarStyle {
                return .darkContent
            }
        }
