class PrescriptionViewController < UIViewController

  def initialize(link)
    @link = link
  end

  def viewDidLoad
    super
    self.title = 'Prescription'
    @web_view = UIWebView.alloc.initWithFrame(view.frame)
    view.addSubview(@web_view)
    @web_view.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(@link)))
  end

  def viewWillAppear(animated)
    super
    @web_view.delegate = self
  end

  def viewWillDisappear(animated)
    super
    @web_view.stopLoading
    @web_view.delegate = nil
    UIApplication.sharedApplication.networkActivityIndicatorVisible = false
  end

  #pragma mark - UIWebViewDelegate

  def webViewDidStartLoad(webView)
    # starting the load, show the activity indicator in the status bar
    UIApplication.sharedApplication.networkActivityIndicatorVisible = true
  end

  def webViewDidFinishLoad(webView)
    # finished loading, hide the activity indicator in the status bar
    UIApplication.sharedApplication.networkActivityIndicatorVisible = false;
  end

  def webView(webView, didFailLoadWithError: error)
    return if error.code == NSURLErrorCancelled
    # load error, hide the activity indicator in the status bar
    UIApplication.sharedApplication.networkActivityIndicatorVisible = false

    # report the error inside the webview
    error_string = NSString.stringWithFormat("<!doctype html><html><head><meta http-equiv='Content-Type' content='text/html;charset=utf-8'><title></title></head><body><div style='width: 100%; text-align: center; font-size: 36px; color: red; font-family: Helvetica'>An error occurred:<br>%@<br>Trying to access %@</div></body></html>", error.localizedDescription, @article.link)
    @web_view.loadHTMLString(error_string, baseURL: nil)
  end
end
