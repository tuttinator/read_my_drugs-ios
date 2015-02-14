class WelcomeViewController < UIViewController
  attr_reader :qrReaderViewController

  LANGUAGES = [
    { code: :en, label: 'English' },
    { code: :ma, label: 'Māori' },
    { code: :'zh-CHS', label: '普通話 (Mandarin)' },
    { code: :ko, label: '한국 (Korean)' }
  ]

  TITLE_LABEL = {
    en: 'Click here and take a photo of the QR code on your medication',
    ma: 'Pāwhiri ki konei, ka tango i te whakaahua o te waehere UT i runga i tou rongoā',
    :'zh-CHS' => '點擊這裡，走的QR代碼的照片上你的藥物',
    ko: '여기를 클릭하여 약물 치료에 QR 코드의 사진을 촬영'
  }

  def viewDidLoad
    super
    setupUI
    true
  end

  def setupUI
    self.title = 'Scan your prescription label'
    self.view.backgroundColor = UIColor.whiteColor
    @label = setupLabel
    @picker = setupPicker
    @button = setupButton
    @button.addTarget(self, action: :loadQRReaderView, forControlEvents: UIControlEventTouchUpInside)
    self.view.addSubview(@label)
    self.view.addSubview(@button)
    self.view.addSubview(@picker)
  end

  def setupButton
    button = UIButton.new
    button.setTitle('Scan code', forState: UIControlStateNormal)
    button.frame = [[20, 250], [280, 30]]
    button.setTitleColor(UIColor.blueColor, forState: UIControlStateNormal)
    button
  end

  def setupLabel
    label = UILabel.new
    label.frame = [[20, 100], [280, 80]]
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakByWordWrapping
    label.text = TITLE_LABEL[App.delegate.selectedLanguage]
    label
  end

  def setupPicker
    picker = UIPickerView.new
    picker.frame = [[0, 350], [320, 162]]
    picker.dataSource = self
    picker.delegate = self
    picker
  end

  def pickerView(pickerView, numberOfRowsInComponent: component)
    LANGUAGES.length
  end

  def pickerView(pickerView, titleForRow: row, forComponent: component)
    LANGUAGES[row][:label]
  end

  def numberOfComponentsInPickerView(pickerView)
    1
  end

  def pickerView(pickerView, didSelectRow: row, inComponent: component)
    App.delegate.selectedLanguage = LANGUAGES[row][:code]
    @label.text = TITLE_LABEL[App.delegate.selectedLanguage]
    # fire off change to label, etc
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

    self.dismissViewControllerAnimated(true, completion: lambda {
      NSLog result
      App.delegate.navigationController.pushViewController(PrescriptionViewController.new(link(result)), animated: true)
    })
  end

  def readerDidCancel(reader)
    NSLog 'readerDidCancel called'
    self.dismissViewControllerAnimated(true, completion: nil)
  end

  def link(result)
    'http://read-my-meds.herokuapp.com/api/v1/prescriptions/' + App.delegate.selectedLanguage + '/' + result
  end
end
