#stock_picker.rb
require 'pry-byebug'

def stock_picker(array)
    array2 = array.clone
    best_days = []
    profit = nil
    array.each do |buy_day|
        array2.shift
        array2.each do |sell_day|
            if profit == nil
                profit = sell_day - buy_day
                best_days = [array.index(buy_day), array.index(sell_day)]
            elsif profit < sell_day - buy_day
                profit = sell_day - buy_day
                best_days = [array.index(buy_day), array.index(sell_day)]
            end
        end
    end
    p best_days
end


stock_picker([17,3,6,9,15,8,6,1,10])
