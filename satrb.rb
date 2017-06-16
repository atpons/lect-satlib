module Passat
  def invert(i)
    return not(i)
  end

  def load(file)
      @clause = []
     File.open(file) do |f|
       f.each_line do |o|
         @temparr = []
         case o[0]
         when "c"
         when "p"
         else
           o.split("0\n"||"0").each do |x|
             @temparr2 = []
             x.split.each do |y|
               @temparr2.push(y.to_i)
             end
             @temparr.push(@temparr2)
           end
           @temparr.each do |arr|
             unless arr.empty?
               @clause.push(arr)
             end
           end
         end
       end
     end
  end


  class Boolean
  include Passat
  
  def input(input)
    @input = input
  end

  def file_load(file)
    self.load(file)
    @boolean = @clause.dup
    @boolean.each_with_index do |a, i|
      a.each_with_index do |b, j|
       if b.to_i < 0
          @boolean[i][j] = invert(@input[b.to_i.abs - 1])
       else
          @boolean[i][j] = @input[b.to_i.abs - 1]
       end
      end
    end
  end
  
  def check()
  @formula = []
  @boolean.each do |v|
    @formula.push("(" + v.join("||") + ")")
  end

 # puts @formula.join("&")

  return eval(@formula.join("&"))
  end 

  end
end


__END__
 class Boolean
  include Passat
  
  def input(input)
    @input = input
  end

  def file_load(file)
    self.load(file)
    @boolean = @clause.dup
    @boolean.each_with_index do |a, i|
      a.each_with_index do |b, j|
        if b.to_i[0] < 0
          @boolean[i][j] = invert(@input[b.to_i.abs - 1])
        else
          @boolean[i][j] = @input[b.to_i.abs - 1]
        end
      end
    end
  end


 end
