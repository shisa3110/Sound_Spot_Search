class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # enumの日本語化に使用するメソッド。日本語化された enum の値を取得して返す。
  def self.human_attribute_enum_value(attr_name, value)
    return if value.blank?
    human_attribute_name("#{attr_name}.#{value}")
  end
   # カラム名を引数として受け取る。
  def human_attribute_enum(attr_name)
    self.class.human_attribute_enum_value(attr_name, self.send("#{attr_name}"))
  end

  # 入力時セレクトボックスで表示する際の設定
  def self.enum_options_for_select(attr_name)
    self.send(attr_name.to_s.pluralize).map { |k, _| [self.human_attribute_enum_value(attr_name, k), k] }.to_h
  end
end
