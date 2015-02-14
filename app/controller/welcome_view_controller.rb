class WelcomeViewController < UIViewController
  attr_reader :qrReaderViewController

  def viewDidLoad
    super
    setupUI
    true
  end

  def setupUI
    self.title = 'Scan your prescription label'
    self.view.backgroundColor = UIColor.whiteColor
    @button = setupButton
    @button.addTarget(self, action: :loadQRReaderView, forControlEvents: UIControlEventTouchUpInside)
    self.view.addSubview(@button)
  end

  def setupButton
    button = UIButton.new
    button.setTitle('Scan code', forState: UIControlStateNormal)
    button.frame = [[20, 100], [280, 30]]
    button.setTitleColor(UIColor.blueColor, forState: UIControlStateNormal)
    button
  end

  def loadQRReaderView
    NSLog 'Button pressed'
    @qrReaderViewController = QRCodeReaderViewController.new
    qrReaderViewController.modalPresentationStyle = UIModalPresentationFormSheet

    qrReaderViewController.delegate = self

    self.presentViewController(qrReaderViewController, animated: true, completion: nil)
  end

  # QR Reader delegate methods

  def reader(reader, didScanResult: result)
    NSLog 'didScanResult called'
    NSLog result

    self.dismissViewControllerAnimated(true, completion: lambda {
      NSLog result
    })
  end

  def readerDidCancel(reader)
    NSLog 'readerDidCancel called'
    self.dismissViewControllerAnimated(true, completion: nil)
  end
end
