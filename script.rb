class Node 
    def initialize(value=nil, left_child=nil, right_child=nil) 
        @value = value 
        @left_child = left_child
        @right_child = right_child
    end
    attr_accessor :value, :left_child, :right_child

end
