require 'date'

module WithTax
  TAX_TABLE = {
    '2019/10/01': 0.10,
    '2014/04/01': 0.08,
    '1997/04/01': 0.05,
    '1989/04/01': 0.03,
  }

  def attr_with_tax(attr_name)
    method_name = "#{attr_name}_with_tax"
    define_method(method_name) do |effective_date = nil|
      effective_date ||= Date.today
      _k, rate = TAX_TABLE.find { |k, _v| Date.parse(k.to_s) <= effective_date }
      rate ||= 0.00
      (send(attr_name) * (1 + rate)).floor
    end
  end
end
