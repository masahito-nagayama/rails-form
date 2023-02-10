class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.match?(value)

    record.errors.add(attribute, "が正しくありません")
  end
end

## ここのクラスのメソッドを使用するには、calss名のEmailFormatValidatorをスネークケースでケースで記述する。
## eail_formatみたいな感じ→詳しくはOrder.rbを見る。