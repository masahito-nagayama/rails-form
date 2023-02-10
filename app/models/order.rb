class Order < ApplicationRecord
  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, length: { maximum: 100 }, email_format: true
  validates :telephone, presence: true, length: { maximum: 11 }, numericality: { only_integer: true }
  validates :delivery_address, presence: true, length: { maximum: 100 }

  after_initialize :format_telephone

  private

  def format_telephone
    self.telephone = telephone.tr("０-９", "0-9").delete("^0-9")
  end
end