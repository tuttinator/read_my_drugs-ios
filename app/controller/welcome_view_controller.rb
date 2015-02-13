class WelcomeViewController < UIViewController
  def viewDidLoad
    super
    setupUI
    true
  end

  def setupUI
    self.title = 'Scan your prescription label'
    self.view.backgroundColor = UIColor.whiteColor
    @button = UIButton.new
    @button.setTitle('Scan code', forState: UIControlStateNormal)
    @button.frame = [[20, 100], [280, 30]]
    @button.setTitleColor(UIColor.blueColor, forState: UIControlStateNormal)
    self.view.addSubview(@button)
  end
end
