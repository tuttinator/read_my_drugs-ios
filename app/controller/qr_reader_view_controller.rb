class QRReaderViewController < QRCodeReaderViewController
  def init
    super
    self.delegate = self
    self.modalPresentationStyle = UIModalPresentationFormSheet
    self
  end
end
