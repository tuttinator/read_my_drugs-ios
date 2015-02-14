class AppDelegate
  attr_reader :navigationController
  attr_accessor :selectedLanguage

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @selectedLanguage = :en
    @navigationController = UINavigationController.alloc.initWithRootViewController(WelcomeViewController.new)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    true
  end
end
