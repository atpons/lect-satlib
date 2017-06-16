require "./satrb.rb"
require "logger"

@ip = "localhost"
@port = 20000

@log = Logger.new(STDOUT)

@c = 0

v_num = 20

torf = [true,false]
@var = Array.new

torf.repeated_permutation(v_num){|l| @var.push(l)}

@filterd_var = Array.new

# Oracle Configuration
@ture_number = 10 # 真である変数の個数を神託せよ．

@log.info("[*] Filtering boolean (true_number=#{@ture_number})")
@var.each do |arr|
  if arr.count(true) == @ture_number
    @filterd_var.push(arr)
  end
end

s_begin = 1 #fixed
s_end = @filterd_var.count

@log.info("[*] Calculation on (standalone) (#{s_begin} to #{s_end})")
@filterd_var.each do |bool|
  a = Passat::Boolean.new
  a.input(bool)
  a.file_load("20.cnf")
  @c += 1
  if a.check
    @log.info("[*] Solved and SAT on (standalone) (times: #{@c})")
    break
  end
end

