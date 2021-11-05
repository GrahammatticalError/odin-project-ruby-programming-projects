# bubble_sort.rb

# This method uses recursion to reiterate back through the array until it is sorted
# from smallest number to largest.

def bubble_sort(array)
    array.each do |i|
        array2 = array.clone
        index = array.index(i)
        first_num = array[index]
        second_num = array[index+1]
        if second_num == nil
            break
        elsif first_num > second_num
            array[index] = second_num
            array[index+1] = first_num
        end
        if array != array2
            bubble_sort(array)
        end
    end
    array
end


p bubble_sort([4,3,78,2,0,2])