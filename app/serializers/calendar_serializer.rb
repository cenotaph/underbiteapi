class CalendarSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id 
  attribute :year do |obj|
    obj.first.first
  end
end